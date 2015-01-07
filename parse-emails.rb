load 'bootstrap.rb'

conn = DBConn.connect

duplicates = conn.exec('
  SELECT email, count(*)
  FROM customers
  GROUP BY email
  HAVING count(*) > 1
')

puts "Found #{duplicates.count} duplicate emails."

duplicates.each do |customer|
  id = conn.exec("SELECT id FROM customers WHERE email = '#{customer['email']}' LIMIT 1").getvalue(0,0)

  puts "Setting all customers' id with email '#{customer['email']}' to #{id}."

  conn.exec("UPDATE customers SET id = #{id} WHERE email = '#{customer['email']}'")
end
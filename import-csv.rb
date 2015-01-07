load 'bootstrap.rb'

conn = DBConn.connect

if ARGV[1] == '--drop'
  conn.exec('DROP TABLE IF EXISTS customers')
end

conn.exec('
  CREATE TABLE IF NOT EXISTS customers (
    id                integer,
    name              varchar(50),
    email             varchar(50),
    billing_country   varchar(50),
    billing_province  varchar(50),
    billing_city      varchar(50),
    shipping_country  varchar(50),
    shipping_province varchar(50),
    shipping_city     varchar(50),
    day               date,
    order_count       integer,
    total_cancelled   integer,
    total_sales       decimal(8,2)
  );
')

i = 1

File.readlines('data.csv').each do |line|
  next if line[0, 4] == 'name' #Skip heading row

  values = ''

  line.split(',').each do |value|
    if value.is_numeric?
      values += ',' + value
    else
      values += ",'#{value}'"
    end
  end

  conn.exec("INSERT INTO customers VALUES(#{i} #{values})")

  i += 1
end
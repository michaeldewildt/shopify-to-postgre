require 'pg'
require 'uri'

if ARGV[0].nil?
  puts 'Usage: command HEROKU_APP_NAME'
  exit
end

class String
  def is_numeric?
    true if Float self rescue false
  end
end

class DBConn
  def self.connect
    database_url = URI(`heroku config:get DATABASE_URL -a #{ARGV[0]}`)

    @conn ||= PGconn.connect(
      port: database_url.port,
      host: database_url.host,
      user: database_url.user,
      password: database_url.password,
      dbname: database_url.path.delete('/')
    )
  end
end
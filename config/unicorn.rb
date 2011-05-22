worker_processes 4
preload_app true
timeout 30

application = "superowl"
app_path = "/var/www/#{application}/current"

listen "/tmp/unicorn.sock", :backlog => 1024
pid "#{app_path}/../shared/pids/unicorn.pid"

# Set the path of the log files inside the log folder of the testapp
stderr_path "#{app_path}/log/unicorn.stderr.log"
stdout_path "#{app_path}/log/unicorn.stdout.log"

before_fork do |server, worker|
  MongoMapper.database.connection.close 
end

after_fork do |server, worker|
  begin
    MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
    MongoMapper.database = "superowl-#{Rails.env}"
    MongoMapper.connection.connect
  rescue => e
    RAILS_DEFAULT_LOGGER.error("Couldn't connect to Mongo Server.\n#{e.backtrace.join('\n')}")
  end
end
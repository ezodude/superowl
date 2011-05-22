worker_processes 4
preload_app true
timeout 30

application = "superowl"

listen "/tmp/unicorn.sock", :backlog => 1024

pid_path = Rails.env == "production" ? 
                "/var/www/#{application}/shared/pids/unicorn.pid" : 
                "#{RAILS_ROOT}/tmp/pids/unicorn.pid"

pid pid_path

# Set the path of the log files inside the log folder of the testapp
stderr_path "#{RAILS_ROOT}/log/unicorn.stderr.log"
stdout_path "#{RAILS_ROOT}/log/unicorn.stdout.log"

before_fork do |server, worker|
  MongoMapper.database.connection.close 
  
  old_pid = '/tmp/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    # someone else did our job for us
    end
  end
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
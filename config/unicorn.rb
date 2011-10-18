worker_processes 4
preload_app true
timeout 30

# application = "superowl"
# 
# listen "#{Rails.env}/tmp/unicorn.sock", :backlog => 1024
# pid "#{Rails.env}/tmp/pids/unicorn.pid"

# before_fork do |server, worker|
#   MongoMapper.database.connection.close 
# end
# 
# after_fork do |server, worker|
#   begin
#     MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
#     MongoMapper.database = "superowl-#{Rails.env}"
#     MongoMapper.connection.connect
#   rescue => e
#     RAILS_DEFAULT_LOGGER.error("Couldn't connect to Mongo Server.\n#{e.backtrace.join('\n')}")
#   end
# end
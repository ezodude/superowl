if ENV['MONGOHQ_URL']
  MongoMapper.config = {RAILS_ENV => {'uri' => ENV['MONGOHQ_URL']}}
else
  MongoMapper.config = {RAILS_ENV => {'uri' => "mongodb://localhost/superowl-#{Rails.env}"}}
end

MongoMapper.connect(RAILS_ENV)

# MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
# MongoMapper.database = "superowl-#{Rails.env}"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end
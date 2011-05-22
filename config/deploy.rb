require "bundler/capistrano"

set :application, "superowl"

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:the-experimenters/#{application}.git"  # Your clone URL
set :scm, "git"

set :user, "deploy"  # The server's user for deploys
#set :use_sudo, false # avoid using the root user
ssh_options[:port] = 22
ssh_options[:username] = 'deploy'
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
ssh_options[:paranoid] = false

set :branch, "master"
set :scm_verbose, true
set :deploy_via, :remote_cache

set :deploy_to, "/var/www/#{application}"
server '109.74.193.80', :web, :app, :db, :primary => true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  task :stop, :roles => :app do
    run "cd #{current_path} && kill -QUIT `cat tmp/pids/unicorn.pid`"
  end 

  task :start, :roles => :app do
    run "cd #{current_path} && /usr/local/bin/unicorn_rails -c config/unicorn.rb -E production -D"
  end

  desc "restart unicorn"
  task :restart, :roles => :web do
    run "cd #{current_path}; [ -f tmp/pids/unicorn.pid ] && kill -USR2 `cat tmp/pids/unicorn.pid` || /usr/local/bin/unicorn_rails -c config/unicorn.rb -E production -D"
  end
end

# namespace :deploy do
#   task :stop, :roles => :app do
#     run "cd #{current_path} && #{try_sudo} kill -QUIT `cat tmp/pids/unicorn.pid`"
#   end 
# 
#   task :start, :roles => :app do
#     run "cd #{current_path} && #{try_sudo} /usr/local/bin/unicorn_rails -c config/unicorn.rb -E production -D"
#   end
# 
#   desc "restart unicorn"
#   task :restart, :roles => :web do
#     run "cd #{current_path}; [ -f tmp/pids/unicorn.pid ] && #{try_sudo} kill -USR2 `cat tmp/pids/unicorn.pid` || #{try_sudo} /usr/local/bin/unicorn_rails -c config/unicorn.rb -E production -D"
#   end
# end
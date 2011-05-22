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

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart do ; end
end
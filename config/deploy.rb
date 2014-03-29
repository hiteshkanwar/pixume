require "rvm/capistrano"
require "bundler/capistrano"
set :application, "107.170.114.144"
set :deploy_to, "/home/pixume/public_html/#{application}"
set :repository,  "git@github.com:hiteshkanwar/pixume.git"
set :port, 3000
set :use_sudo, true
set :user_sudo, false
set :rails_env, "production" # sets your server environment to Production mode
set :ssh_options, { :forward_agent => true }
set :scm, :git  # sets version control

default_run_options[:pty] = true
set :user, "pixume"
role :web, application
role :app, application
role :db,  application, :primary => true

after "deploy:restart", "deploy:cleanup"
after "deploy", "rvm:trust_rvmrc"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

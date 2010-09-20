$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
require "bundler/capistrano"

set :rvm_ruby_string, 'jruby'

set :application,     "VOEIS - HIS Gateway"
set :use_sudo,        false

set :repository,      "git://github.com/yogo/VOEIS-HIS-Gateway.git"
set :scm,             :git
set :shell,           "/bin/bash"

set  :user,           "voeis-demo"
role :web,            "klank.msu.montana.edu"
role :app,            "klank.msu.montana.edu"
set  :deploy_to,      "/home/#{user}/vhgw"

default_run_options[:pty] = false

namespace :deploy do
  desc "Restart Server"
  task :restart, :roles => :app do
    deploy.stop
    deploy.start
  end

  desc "Start Server"
  task :start, :roles => :app do
    run "TZ=America/Denver #{release_path}/bin/vhgw.sh start"
  end

  desc "Stop Server"
  task :stop, :roles => :app do
    run "TZ=America/Denver #{release_path}/bin/vhgw.sh stop"
  end
end
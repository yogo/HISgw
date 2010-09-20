$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
require "bundler/capistrano"

set :rvm_ruby_string, 'jruby'
#set :rvm_type,        :user

set :application,     "VOEIS - HIS Gateway"
set :use_sudo,        false

set :repository,      "git@github.com:yogo/VOEIS-HIS-Gateway.git"
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
    # This should call stop, then start
  end

  desc "Start Server"
  task :start, :roles => :app do
    run "nohup rackup -w -p 4000 -P #{release_path}/tmp/vhgw.pid 2>&1 >& #{release_path}/log/rackup.out &"
  end

  desc "Stop Server"
  task :stop, :roles => :app do
    run "kill -9 `cat #{release_path}/tmp/vhgw.pid`"
  end
end
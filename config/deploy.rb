set :application, "VOEIS - HIS Gateway"
set :repository,  "set your repository location here"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "voeis.msu.montana.edu"                         # Your HTTP server, Apache/etc
role :app, "voeis.msu.montana.edu"                         # This may be the same as your `Web` server

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
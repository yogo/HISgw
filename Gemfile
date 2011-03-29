source "http://rubygems.org"

DM_VERSION = "~> 1.0.2"

gem "sinatra"
gem "dm-core",              DM_VERSION
gem "dm-validations",       DM_VERSION
gem "dm-serializer",        DM_VERSION
gem "dm-sqlserver-adapter", DM_VERSION
gem "haml"
#gem "extlib"
#gem "rack-jetty"
gem "activesupport" #, :require => "active_support/all"

gem "i18n"

gem "rchardet"

gem "ffi-ncurses"
#gem "sinatra-reloader",   :require => "sinatra/reloader"

gem "trinidad", :require => nil
gem "trinidad_daemon_extension", :require => nil


group :development do
  gem "capistrano"
end

platforms :jruby do
  gem "jruby-openssl"
  gem "jrexml", :require => "rexml/document"
end

source "http://rubygems.org"

DM_VERSION = "~> 1.0.2"

gem "sinatra"
gem "dm-core",              DM_VERSION
gem "dm-validations",       DM_VERSION
gem "dm-serializer",        DM_VERSION
gem "dm-sqlserver-adapter", DM_VERSION
gem "haml"
#gem "extlib"
gem "rack-jetty"
gem "activesupport" #, :require => "active_support/all"

gem "i18n"

gem 'rchardet'

group :development do
  gem "capistrano"
  gem "sinatra-reloader",   :require => "sinatra/reloader"
end

platforms :jruby do
  gem "jruby-openssl"
  gem "jrexml", :require => "rexml/document"
end

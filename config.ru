# Standard requirements for Bundler management
require 'rubygems'
require 'bundler/setup'

running_environment = ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development

# Load the bundler gemset
Bundler.require(:default, running_environment)

# Load DataMapper repository configurations
require 'config/datamapper'

# Load DataMapper models for HIS
require 'app/models/his/his'

# This is a hack to fix rack content-type handling
require 'app/rack/request'

# Load the Application Version
load File.join(File.dirname(__FILE__), 'VERSION')

# Load the application
require 'app/main'

# Run the gateway
run HISGateway

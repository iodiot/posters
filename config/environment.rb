# Load the rails application
require File.expand_path('../application', __FILE__)

Rails.logger = Logger.new("log/application")

# Initialize the rails application
Posters::Application.initialize!

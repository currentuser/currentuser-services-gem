require 'rubygems'
require 'bundler'
Bundler.setup(:default, :development)

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require 'awesome_print'
require 'action_controller'
require 'dotenv'
Dotenv.load

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'currentuser/services'

Currentuser::Services.configure do |config|
  config.project_id = ENV['CURRENTUSER_PROJECT_ID_FOR_TESTS']
end

Currentuser::Services.configure do |config|
  config.currentuser_services_host = ENV['CURRENTUSER_SERVICES_HOST']
  config.currentuser_services_public_key = ENV['CURRENTUSER_SERVICES_PUBLIC_KEY']
end

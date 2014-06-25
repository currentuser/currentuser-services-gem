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
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'currentuser/services'

Currentuser::Services.configure do |config|
  config.application_id = ENV['CURRENTUSER_APPLICATION_ID_FOR_TESTS']
end

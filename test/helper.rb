require 'rubygems'
require 'bundler'
Bundler.setup(:default, :development)

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require 'awesome_print'
require 'action_controller'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'currentuser/services'

Currentuser::Services.configure do |config|
  config.application_id = 'fake_application_id'
end


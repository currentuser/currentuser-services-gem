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

# Load and configure this gem (currentuser-services)
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'currentuser/services'
Currentuser::Services.configure do |config|
  config.project_id = ENV['CURRENTUSER_PROJECT_ID_FOR_TESTS']
  config.currentuser_services_host = ENV['CURRENTUSER_SERVICES_HOST']
  config.currentuser_services_public_key = ENV['CURRENTUSER_SERVICES_PUBLIC_KEY']
end

# Load and configure 'currentuser-data' for tests.
# Note this is required only in 'integration_test.rb'.
require 'currentuser/data'
require 'currentuser/data/test/helpers'
Currentuser::Data::BaseResource.site = ENV['CURRENTUSER_DATA_URL']
Currentuser::Data::Test::UseReadApi.currentuser_project_id_for_tests =
    Currentuser::Services.configuration.project_id

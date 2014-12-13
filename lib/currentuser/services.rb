require 'gem_config'
require 'encrypto_signo'
require 'rails'
require 'currentuser/services/controllers/authenticates'
require 'currentuser/services/engine'

module Currentuser
  module Services
    include GemConfig::Base

    with_configuration do
      # Public API
      has :project_id, classes: String

      # Developer API
      has :currentuser_services_host, classes: String
      has :currentuser_services_public_key, classes: String
      has :currentuser_project_id_for_tests, classes: String
    end
  end
end

Currentuser::Services.configure do |config|
  config.currentuser_services_host = 'http://services.currentuser.io'
  config.currentuser_services_public_key = File.read(
    File.join(File.dirname(__FILE__), '..', '..', 'config', 'currentuser-services_public_key.txt')
  )
end

module ActionController
  class Base
    include Currentuser::Services::Authenticates
    helper_method :currentuser_id, :currentuser_sign_in_url, :currentuser_sign_up_url, :currentuser_sign_out_url
  end
end

class ActionDispatch::Routing::Mapper
  def currentuser
    mount Currentuser::Services::Engine => '/currentuser'
  end
end

# For an unclear reason, we have to require this file late in the process, otherwise using application have
# problems on start up
require 'controllers/currentuser/services/sessions_controller'

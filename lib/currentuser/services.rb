require 'gem_config'
require 'encrypto_signo'
require 'currentuser/services/controllers/authenticates'

module Currentuser
  module Services
    include GemConfig::Base

    with_configuration do
      # Public API
      has :application_id, classes: String

      # Developer API
      has :currentuser_services_host, classes: String
      has :currentuser_services_public_key, classes: String
      has :currentuser_application_id_for_tests, classes: String
    end
  end
end

Currentuser::Services.configure do |config|
  config.currentuser_services_host = 'http://localhost:3001'
  config.currentuser_services_public_key = File.read(
    File.join(File.dirname(__FILE__), '..', '..', 'config', 'currentuser-services_public_key.txt')
  )
end


module ActionController
  class Base
    include Currentuser::Services::Authenticates
    before_action :try_sign_in
    helper_method :currentuser_id, :sign_in_url, :sign_up_url
  end
end

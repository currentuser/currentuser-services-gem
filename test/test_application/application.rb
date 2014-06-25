require 'rails'
require 'action_controller/railtie'

module TestRailsApp
  class Application < Rails::Application
    config.secret_token = 'f6da1f7d3105c589bc3f36f3e78ee794'

    routes.draw do
      root 'test_rails_app/homes#outside'
      get '/outside' => 'test_rails_app/homes#outside'
      get '/inside' => 'test_rails_app/homes#inside'
    end
  end

  class HomesController < ActionController::Base
    before_action :require_currentuser, except: :outside

    def outside
      render text: 'Public page'
    end

    def inside
      render text: 'Private page'
    end
  end
end

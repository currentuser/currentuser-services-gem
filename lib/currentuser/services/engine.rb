module Currentuser::Services
  class Engine < ::Rails::Engine
    isolate_namespace Currentuser::Services

    # Inspired by http://pivotallabs.com/rails-autoloading-for-your-gem/
    config.autoload_paths += Dir["#{config.root}/app/**/"]
  end
end

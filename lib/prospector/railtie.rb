require_relative 'rack_app'

module Prospector
  class Railtie < Rails::Railtie
    initializer 'prospector.railtie' do |app|
      ActiveSupport.on_load :action_controller do |app|
        app.middleware.insert(0, Prospector::RackApp)
      end
    end
  end
end

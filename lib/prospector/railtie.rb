module Prospector
  class Railtie < Rails::Railtie
    initializer 'prospector.railtie' do |app|
      ActiveSupport.on_load :action_controller do |app|
        Background.enqueue
      end
    end
  end
end

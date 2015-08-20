module Prospector
  class Railtie < Rails::Railtie
    config.after_initialize do
      Background.enqueue unless Object.const_defined?('Rake')
    end
  end
end

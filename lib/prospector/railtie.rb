module Prospector
  class Railtie < Rails::Railtie
    config.after_initialize do
      Background.enqueue unless Object.const_defined?('Rake')
    end

    rake_tasks do
      require File.expand_path('../tasks', __FILE__)
    end
  end
end

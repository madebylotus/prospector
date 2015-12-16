module Prospector
  class Railtie < Rails::Railtie
    config.after_initialize do
      Background.enqueue if Background.auto_reporting_enabled?
    end

    rake_tasks do
      require File.expand_path('../tasks', __FILE__)
    end
  end
end

module Prospector
  class Railtie < Rails::Railtie
    config.after_initialize do
      Background.enqueue
    end
  end
end

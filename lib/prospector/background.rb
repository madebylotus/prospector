require "prospector/background/coordinator"
require "prospector/background/notify_job" if defined?(ActiveJob::Base)

module Prospector
  module Background

    def enqueue
      Coordinator.new.enqueue
    end

    module_function :enqueue
  end
end

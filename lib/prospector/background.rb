require "prospector/background/coordinator"
require "prospector/background/notify_job" if defined?(ActiveJob::Base)
require "prospector/background/notify_worker" if defined?(Sidekiq::Worker)

module Prospector
  module Background

    def enqueue
      Coordinator.new.enqueue
    end

    module_function :enqueue
  end
end

module Prospector; module Background
  class Coordinator
    def enqueue
      return unless Prospector.enabled?

      case adapter_name
      when :active_job then enqueue_via_active_job
      when :sidekiq then enqueue_via_sidekiq
      when :inline then perform_immediately
      when :none then return
      else
        raise UnsupportedAdapterError.new(adapter_name)
      end
    end

    private

    def adapter_name
      @adapter_name ||= Prospector.configuration.background_adapter
    end

    def enqueue_via_active_job
      raise UnsupportedAdapterError unless Object.const_defined?('ActiveJob::Base')

      NotifyJob.perform_later
    end

    def enqueue_via_sidekiq
      raise UnsupportedAdapterError unless Object.const_defined?('Sidekiq::Worker')

      NotifyWorker.perform_async
    end

    def perform_immediately
      Prospector.notify!
    end
  end
end; end

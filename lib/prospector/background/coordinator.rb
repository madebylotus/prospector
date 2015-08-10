module Prospector; module Background
  class Coordinator
    def enqueue
      enqueue_via_active_job if defined?(NotifyJob)
    end

    private

    def enqueue_via_active_job
      NotifyJob.perform_later
    end
  end
end; end

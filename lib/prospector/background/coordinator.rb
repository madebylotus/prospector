module Prospector; module Background
  class Coordinator
    def enqueue
      enqueue_via_active_job and return if defined?(NotifyJob)
      enqueue_via_sidekiq and return if defined?(NotifyWorker)
    end

    private

    def enqueue_via_active_job
      NotifyJob.perform_later
    end

    def enqueue_via_sidekiq
      NotifyWorker.perform_async
    end
  end
end; end

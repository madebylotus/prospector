module Prospector
  module Background
    autoload :Coordinator,          'prospector/background/coordinator'
    autoload :EnvironmentDetector,  'prospector/background/environment_detector'
    autoload :NotifyJob,            'prospector/background/notify_job'
    autoload :NotifyWorker,         'prospector/background/notify_worker'

    module_function

    def enqueue
      service = Coordinator.new

      service.enqueue
    end

    def auto_reporting_enabled?
      service = EnvironmentDetector.new

      service.rails_server?
    end
  end
end

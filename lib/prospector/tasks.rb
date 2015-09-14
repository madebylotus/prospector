require 'rake'

namespace :prospector do

  # Will load and run initializers for configuration info if provided
  task :require do
    Rake::Task['environment'].invoke if defined?(Rails)

    App.config if defined?(Motion::Project)
  end

  desc 'Deliver usage details to Prospector API service'
  task deliver: ['prospector:require'] do
    Prospector.notify!
  end

  task deliver_quietly: ['prospector:require'] do
    if Prospector.enabled?
      App.info 'Prospector', 'Begin uploading usage details to API'

      Prospector.notify!

      App.info 'Prospector', 'Upload complete'
    end
  end

  # Hook into archive build hook for RubyMotion projects
  if Rake::Task.task_defined?('build:device')
    Rake::Task['build:device'].enhance(['prospector:deliver_quietly'])
  end
end

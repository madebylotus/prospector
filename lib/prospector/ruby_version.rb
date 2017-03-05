module Prospector
  class RubyVersion
    extend Forwardable

    def_delegators :@ruby_version, :patchlevel, :engine
    alias_method :patch_level, :patchlevel

    def initialize
      @ruby_version = Bundler::RubyVersion.system
    end

    def to_json
      {
        engine: engine,
        engine_version: engine_version,
        version: version,
        patch_level: patch_level
      }
    end

    def engine_version
      @ruby_version.engine_gem_version.version
    end

    def version
      @ruby_version.gem_version.version
    end

    def to_s
      @ruby_version.single_version_string
    end
  end
end

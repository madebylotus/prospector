module Prospector
  class RubyVersion
    extend Forwardable

    def_delegators :@ruby_version, :version, :patchlevel, :engine, :engine_version, :to_s
    alias_method :patch_level, :patchlevel

    def initialize
      @ruby_version = Bundler.ruby_version
    end

    def to_json
      {
        engine: engine,
        engine_version: engine_version,
        version: version,
        patch_level: patch_level
      }
    end
  end
end

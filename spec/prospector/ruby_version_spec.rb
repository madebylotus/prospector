require 'spec_helper'

describe Prospector::RubyVersion do
  let(:bundler_ruby_version) { Bundler::RubyVersion.system }

  subject { described_class.new }

  describe '#to_json' do
    it 'returns a Hash' do
      expect(subject.to_json).to be_a(Hash)
    end

    it 'returns the information to build a new Bundler::RubyVersion later' do
      json = subject.to_json

      expect(json).to include(engine: bundler_ruby_version.engine)
      expect(json).to include(engine_version: bundler_ruby_version.engine_gem_version.version)
      expect(json).to include(version: bundler_ruby_version.gem_version.version)
      expect(json).to include(patch_level: bundler_ruby_version.patchlevel)
    end
  end

  describe 'attributes' do
    it 'delegates #version' do
      expect(subject.version).to eq(bundler_ruby_version.gem_version.version)
    end

    it 'delegates #patch_level' do
      expect(subject.patch_level).to eq(bundler_ruby_version.patchlevel)
    end

    it 'delegates #engine' do
      expect(subject.engine).to eq(bundler_ruby_version.engine)
    end

    it 'delegates #engine_version' do
      expect(subject.engine_version).to eq(bundler_ruby_version.engine_gem_version.version)
    end
  end
end

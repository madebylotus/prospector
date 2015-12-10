require 'spec_helper'

module Prospector
  RSpec.describe Background::Coordinator do
    before do
      Prospector.configure do |config|
        config.enabled = true
      end
    end

    context 'when inline' do
      before do
        Prospector.configure do |config|
          config.background_adapter = :inline
        end
      end

      it 'performs immediately' do
        expect(Prospector).to receive(:notify!)

        subject.enqueue
      end
    end

    context 'when none' do
      before do
        Prospector.configure do |config|
          config.background_adapter = :none
        end
      end

      it 'skips calling our API' do
        expect(Prospector).not_to receive(:notify!)

        subject.enqueue
      end
    end

    context 'when unrecognized' do
      before do
        Prospector.configure do |config|
          config.background_adapter = :garbage
        end
      end

      it 'raises an error' do
        expect { subject.enqueue }.to raise_error(UnsupportedAdapterError)
      end
    end
  end
end

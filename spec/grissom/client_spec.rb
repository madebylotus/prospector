require 'spec_helper'

module Prospector
  describe Client do
    context 'with invalid credentials' do
      before do
        Prospector.configure do |config|
          config.secret_token = 'username'
          config.client_secret = 'password'
        end
      end

      let(:specifications) { [] }

      it 'raises error' do
        VCR.use_cassette 'invalid credentials' do
          expect { subject.deliver(specifications) }.to raise_error(AuthenticationError)
        end
      end
    end

    context 'with valid credentials' do
      before do
        Prospector.configure do |config|
          config.secret_token = 'username'
          config.client_secret = 'password'
        end
      end

      let(:specification) { double(name: 'devise', version: Gem::Version.new('4.2.1')) }
      let(:specifications) { [ specification ] }

      it 'returns true' do
        VCR.use_cassette 'valid credentials' do
          expect(subject.deliver(specifications)).to be_truthy
        end
      end
    end

    context 'when encountering an error' do
      let(:specifications) { [] }

      before do
        Prospector.configure do |config|
          config.secret_token = 'username'
          config.client_secret = 'password'
        end
      end

      it 'raises an error' do
        VCR.use_cassette 'server 500 error' do
          expect { subject.deliver(specifications) }.to raise_error(UnknownError)
        end
      end
    end
  end
end

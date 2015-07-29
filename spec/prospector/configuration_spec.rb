require 'spec_helper'

module Prospector
  describe Configuration do
    context 'empty configuration object' do
      it 'raises error when accessing token' do
        expect { subject.secret_token }.to raise_error(InvalidCredentialsError)
      end

      it 'raises error when accessing secret' do
        expect { subject.client_secret }.to raise_error(InvalidCredentialsError)
      end
    end

    context 'when configured via ENV variables' do
      before do
        allow(ENV).to receive(:[]).with('PROSPECTOR_SECRET_TOKEN').and_return('token')
        allow(ENV).to receive(:[]).with('PROSPECTOR_CLIENT_SECRET').and_return('password')
      end

      it 'returns the token' do
        expect(subject.secret_token).to eq('token')
      end

      it 'returns the secret' do
        expect(subject.client_secret).to eq('password')
      end

      it 'returns true when enabled' do
        allow(ENV).to receive(:[]).with('PROSPECTOR_ENABLED').and_return('true')

        expect(subject).to be_enabled
      end

      it 'returns false for a garbage input' do
        allow(ENV).to receive(:[]).with('PROSPECTOR_ENABLED').and_return('garbage')

        expect(subject).not_to be_enabled
      end
    end

    context 'when configured directly' do
      before do
        subject.secret_token = 'token'
        subject.client_secret = 'password'
        subject.enabled = false
      end

      it 'returns the token' do
        expect(subject.secret_token).to eq('token')
      end

      it 'returns the secret' do
        expect(subject.client_secret).to eq('password')
      end

      it 'returns false when disabled' do
        expect(subject).not_to be_enabled
      end

      it 'ignores the ENV setting' do
        allow(ENV).to receive(:[]).with('PROSPECTOR_ENABLED').and_return('true')

        expect(subject).not_to be_enabled
      end
    end
  end
end

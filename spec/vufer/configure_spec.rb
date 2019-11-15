require 'spec_helper'

RSpec.describe Vufer::Configure do
  context 'when loading defaults keys' do
    before do
      Vufer.use_defaults
    end

    it 'the access key is empty' do
      expect(Vufer.access_key).to eq ''
    end

    it 'the secret key is empty' do
      expect(Vufer.secret_key).to eq ''
    end
  end

  context 'when configuring the vufer with new keys' do
    before do
      Vufer.configure do |config|
        config.access_key = '4cc3s'
        config.secret_key = 's3cr3t'
      end
    end

    it 'the access key is not empty' do
      expect(Vufer.access_key).to eq '4cc3s'
    end

    it 'the secret key is not empty' do
      expect(Vufer.secret_key).to eq 's3cr3t'
    end
  end

  context 'when loading from environment variable' do
    before do
      ENV['VWS_ACCESS_KEY'] = '4cc3s'
      ENV['VWS_SECRET_KEY'] = 's3cr3t'
    end

    it 'the access key is not empty' do
      expect(Vufer.access_key).to eq '4cc3s'
    end

    it 'the secret key is not empty' do
      expect(Vufer.secret_key).to eq 's3cr3t'
    end
  end
end

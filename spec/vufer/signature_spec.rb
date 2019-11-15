require 'spec_helper'

RSpec.describe Vufer::Signature do
  context 'when generating a new signature' do
    before do
      Vufer.access_key = '4cc3s'
      Vufer.secret_key = 's3cr3t'
    end

    it 'returns a token to include in header' do
      token = Vufer::Signature.generate('/targets', '', 'GET')

      expect(token).not_to be_empty
    end
  end

  context 'when the access and secret keys are empty' do
    before do
      Vufer.access_key = ''
      Vufer.secret_key = ''
    end

    it 'raise KeyEnvironmentError exception' do
      expect {
        Vufer::Signature.generate('/targets', '', 'GET')
      }.to raise_error Vufer::KeyEnvironmentError
    end
  end
end

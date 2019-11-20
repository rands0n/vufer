require 'spec_helper'

RSpec.describe Vufer::Target do
  describe '#find' do
    context 'when retrieving a specific target' do
      context 'when credentials are set' do
        before do
          Vufer.access_key = ENV['VWS_ACCESS_KEY']
          Vufer.secret_key = ENV['VWS_SECRET_KEY']
        end

        it 'returns http status code ok' do
          VCR.use_cassette('targets/find') do
            target = Vufer::Target.find('8c6f38cd1a084adf92aad3541c83db37')

            expect(target['status']).to eq 'success'
          end
        end

        it 'include transaction id on the request' do
          VCR.use_cassette('targets/find') do
            target = Vufer::Target.find('8c6f38cd1a084adf92aad3541c83db37')

            expect(target['transaction_id']).not_to be_empty
          end
        end

        %w[
          target_id active_flag name
          width tracking_rating reco_rating
        ].each do |att|
          it "includes attribute #{att}" do
            VCR.use_cassette('targets/find') do
              target = Vufer::Target.find('8c6f38cd1a084adf92aad3541c83db37')

              expect(target['target_record']).to include att
            end
          end
        end
      end
    end
  end

  describe '#all' do
    before do
      Vufer.access_key = ENV['VWS_ACCESS_KEY']
      Vufer.secret_key = ENV['VWS_SECRET_KEY']
    end

    it 'returns http status success' do
      VCR.use_cassette('targets/all') do
        target_ids = Vufer::Target.all

        expect(target_ids['result_code']).to eq 'Success'
      end
    end

    it 'the results is an array of ids' do
      VCR.use_cassette('targets/all') do
        target_ids = Vufer::Target.all

        expect(target_ids['results']).to be_a Array
      end
    end
  end
end

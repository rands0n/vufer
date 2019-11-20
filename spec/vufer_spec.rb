RSpec.describe Vufer do
  it 'has a version number' do
    expect(Vufer::VERSION).not_to be nil
  end

  describe '#summary' do
    before do
      Vufer.configure do |config|
        config.access_key = ENV['VWS_ACCESS_KEY']
        config.secret_key = ENV['VWS_SECRET_KEY']
      end
    end

    it 'returns http status code ok' do
      VCR.use_cassette('summary') do
        summary = Vufer.summary

        expect(summary['result_code']).to eq 'Success'
      end
    end

    %w[
      active_images inactive_images failed_images processing_images
      target_quota request_quota reco_threshold request_usage
      total_recos current_month_recos previous_month_recos
    ].each do |att|
      it "includes attribute #{att}" do
        VCR.use_cassette('summary') do
          summary = Vufer.summary

          expect(summary).to include att
        end
      end
    end
  end
end

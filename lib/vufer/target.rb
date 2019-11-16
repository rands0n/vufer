require 'time'
require 'faraday'

module Vufer
  class Target
    def self.find(id)
      uri = "#{Vufer::BASE_URI}/targets/#{id}"
      time = Time.now.httpdate
      signature = Vufer::Signature.generate("/targets/#{id}", nil, 'GET', time)

      res = Faraday.get(uri, {}, {
        'Date': time,
        'Authorization': "VWS #{Vufer.access_key}:#{signature}"
      })

      JSON.parse(res.body)
    rescue StandardError => e
      e.message
    end
  end
end

require 'time'

require 'vufer/version'
require 'vufer/configure'
require 'vufer/signature'
require 'vufer/target'

module Vufer
  extend Configure

  BASE_URI = 'https://vws.vuforia.com'.freeze

  class Error < StandardError; end
  class KeyEnvironmentError < Error; end

  class << self
    ##
    # Returns a summary from targets, quota and images from Vuforia.
    #
    # @result [JSON] object containing all the info about targets, quota and images.
    def summary
      time = Time.now.httpdate
      signature = Vufer::Signature.generate('/summary', nil, 'GET', time)

      res = Faraday.get("#{Vufer::BASE_URI}/summary", {}, {
        'Date': time,
        'Authorization': "VWS #{Vufer.access_key}:#{signature}"
      })

      JSON.parse(res.body)
    rescue StandardError => e
      e.message
    end
  end
end

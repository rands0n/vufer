# frozen_string_literal: true

require 'time'
require 'faraday'

module Vufer
  class Target
    class << self
      ##
      # Find a specific target on Vuforia Web Services API.
      #
      # @param [String] the identifier that exists on Vuforia.
      #
      # @return [JSON] the object parsed in JSON from Vuforia.
      def find(id)
        time = Time.now.httpdate
        signature = Vufer::Signature.generate("/targets/#{id}", nil, 'GET', time)

        res = Faraday.get("#{Vufer::BASE_URI}/targets/#{id}", {}, {
          Date: time,
          Authorization: "VWS #{Vufer.access_key}:#{signature}"
        })

        JSON.parse(res.body)
      rescue StandardError => e
        e.message
      end

      ##
      # List all targets associated with server access keys and cloud database.
      #
      # @return [Array] A list of target ids associated with the account
      def all
        time = Time.now.httpdate
        signature = Vufer::Signature.generate('/targets', nil, 'GET', time)

        res = Faraday.get("#{Vufer::BASE_URI}/targets", {}, {
          Date: time,
          Authorization: "VWS #{Vufer.access_key}:#{signature}"
        })

        JSON.parse(res.body)
      rescue StandardError => e
        e.message
      end
    end
  end
end

# frozen_string_literal: true

require 'openssl'
require 'base64'
require 'digest/md5'
require 'json'
require 'open-uri'

module Vufer
  class Signature
    HEX_DIGEST = 'd41d8cd98f00b204e9800998ecf8427e'.freeze

    class << self
      ##
      # Generates the signature based on path, body, http verb and time.
      #
      # @param path [String] the actual path you're sending the request, eg: '/targets'.
      # @param body [Hash] the content when request is in POST or PUT formats.
      # @param verb [String] the HTTP verb used to send the request, eg: POST, PUT, GET, etc...
      # @param time [Time] time in GMT the request is made.
      #
      # @return [String] contains an encrypted token with all the above informartion.
      def generate(path, body, verb, time)
        raise KeyEnvironmentError if Vufer.access_key.empty? || Vufer.secret_key.empty?

        hex_digest = HEX_DIGEST
        content_type = ''

        if verb == 'POST' || verb == 'PUT'
          content_type = 'application/json'
          hex_digest = Digest::MD5.hexdigest(body.to_json)
        end

        to_digest = "#{verb}\n#{hex_digest}\n#{content_type}\n#{time}\n#{path}"

        Base64.encode64(
          OpenSSL::HMAC.digest(
            OpenSSL::Digest::SHA1.new,
            Vufer.secret_key,
            to_digest
          )
        )
      end
    end
  end
end

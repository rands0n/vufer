require 'time'
require 'openssl'
require 'base64'
require 'digest/md5'
require 'json'
require 'open-uri'

module Vufer
  module Signature
    TIME_GMT = Time.now.httpdate
    HEX_DIGEST = 'd41d8cd98f00b204e9800998ecf8427e'.freeze

    def self.generate(path, body, verb)
      raise KeyEnvironmentError if Vufer.access_key.empty? || Vufer.secret_key.empty?

      hex_digest = HEX_DIGEST
      content_type = ''

      if verb == 'POST' || verb == 'PUT'
        content_type = 'application/json'
        hex_digest = Digest::MD5.hexdigest(body.to_json)
      end

      to_digest = "#{verb}\n#{hex_digest}\n#{content_type}\n#{TIME_GMT}\n#{path}"

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

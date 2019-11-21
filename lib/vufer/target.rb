# frozen_string_literal: true

require 'time'
require 'faraday'

module Vufer
  class Target
    class << self
      ##
      # Find a specific target on Vuforia Web Services API.
      #
      # @param ID [String] The identifier that exists on Vuforia.
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

      ##
      # Creates a new target on Vuforia Web Services API.
      #
      # @param Name [String] The name of the image to create
      # @param FileURL [String] Contains the base64 encoded binary recognition image data
      # @param Width [Fixnum] Width of the target in scene unit
      # @param ActiveFlag [Boolean] Indicates whether or not the target is active for query, default: false
      # @param Metadata [Hash] The base64 encoded application metadata associated with the target
      #
      # @return [JSON] A newly target id from Vuforia.
      def create(name, file_path, width = 50.0, active_flag = false, metadata = nil)
        time = Time.now.httpdate
        file_encoded = Base64.encode64(open(file_path) { |io| io.read })
        metadata_encoded = Base64.encode64(metadata.to_s)

        body_hash = {
          name: name, width: width, image: file_encoded,
          active_flag: active_flag, application_metadata: metadata_encoded
        }

        signature = Vufer::Signature.generate(
          '/targets', body_hash, 'POST', time
        )

        res = Faraday.post("#{Vufer::BASE_URI}/targets", body_hash.to_json, {
          Date: time,
          Authorization: "VWS #{Vufer.access_key}:#{signature}",
          'Content-Type': 'application/json',
          Accept: 'application/json'
        })

        JSON.parse(res.body)
      rescue StandardError => e
        e.message
      end

      ##
      # Performs an update for a specific target on the database.
      #
      # @param ID [String] The ID(identifier) of the target on Vuforia.
      # @param Name [String] The name of the image to create
      # @param FileURL [String] Contains the base64 encoded binary recognition image data
      # @param Width [Fixnum] Width of the target in scene unit
      # @param ActiveFlag [Boolean] Indicates whether or not the target is active for query
      # @param Metadata [Hash] The base64 encoded application metadata associated with the target
      #
      # @return [JSON] A info showing success that the target was updated.
      def update(id, name = nil, file_path = nil, width = nil, active_flag = nil, metadata = nil)
        time = Time.now.httpdate
        contents_encoded = file_path ? Base64.encode64(open(file_path) { |io| io.read }) : nil
        metadata_encoded = metadata ? Base64.encode64(metadata.to_s) : nil

        body_hash = {}.merge(name ? { name: name } : {})
        body_hash = body_hash.merge(width ? { width: width } : {})
        body_hash = body_hash.merge(contents_encoded ? { image: contents_encoded } : {})
        body_hash = body_hash.merge(!active_flag.nil? ? { active_flag: active_flag } : {})
        body_hash = body_hash.merge(metadata_encoded ? { application_metadata: metadata_encoded } : {})

        signature = Vufer::Signature.generate("/targets/#{id}", body_hash, 'PUT', time)

        res = Faraday.put("#{Vufer::BASE_URI}/targets/#{id}", body_hash.to_json, {
          Date: time,
          Authorization: "VWS #{Vufer.access_key}:#{signature}",
          'Content-Type': 'application/json',
          Accept: 'application/json'
        })

        JSON.parse(res.body)
      rescue StandardError => e
        e.message
      end

      ##
      # Deletes a specific targets from the database.
      #
      # Note: Targets in a processing status cannot be deleted.
      #
      # @param ID [String] The ID(identifier) of the target on the database.
      #
      # @return [JSON] The result code and transaction id indicating the update was ok.
      def destroy(id)
        time = Time.now.httpdate
        signature = Vufer::Signature.generate("/targets/#{id}", nil, 'DELETE', time)

        res = Faraday.delete("#{Vufer::BASE_URI}/targets/#{id}", {}, {
          Date: time,
          Authorization: "VWS #{Vufer.access_key}:#{signature}"
        })

        JSON.parse(res.body)
      rescue StandardError => e
        e.message
      end

      ##
      # Review all duplicates targets from the database.
      #
      # @param ID [String] The identifier of the target on database.
      #
      # @return [JSON] An Array of ids of similar targets
      def dups(id)
        time = Time.now.httpdate
        signature = Vufer::Signature.generate("/duplicates/#{id}", nil, 'GET', time)

        res = Faraday.get("#{Vufer::BASE_URI}/duplicates/#{id}", {}, {
          Date: time,
          Authorization: "VWS #{Vufer.access_key}:#{signature}"
        })

        JSON.parse(res.body)
      rescue StandardError =>
        e.message
      end

      ##
      # Load a summary of a specific target on the database.
      #
      # @param ID [String] The identifier of the target on database.
      #
      # @return [JSON] All the info about database and target.
      def summary(id)
        time = Time.now.httpdate
        signature = Vufer::Signature.generate("/summary/#{id}", nil, 'GET', time)

        res = Faraday.get("#{Vufer::BASE_URI}/summary/#{id}", {}, {
          Date: time,
          Authorization: "VWS #{Vufer.access_key}:#{signature}"
        })

        JSON.parse(res.body)
      rescue StandardError =>
        e.message
      end
    end
  end
end

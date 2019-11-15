module Vufer
  module Configure
    @@access_key = ''
    @@secret_key = ''

    def configure
      yield self if block_given?
    end

    def access_key=(key)
      @@access_key = key
    end

    def access_key
      @@access_key
    end

    def secret_key=(key)
      @@secret_key = key
    end

    def secret_key
      @@secret_key
    end

    def use_defaults
      configure do |config|
        config.access_key ||= ENV['VWS_ACCESS_KEY']
        config.secret_key ||= ENV['VWS_SECRET_KEY']
      end
    end
  end
end

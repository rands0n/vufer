require 'vufer/version'
require 'vufer/configure'
require 'vufer/signature'
require 'vufer/target'

module Vufer
  extend Configure

  BASE_URI = 'https://vws.vuforia.com'.freeze

  class Error < StandardError; end
  class KeyEnvironmentError < Error; end
end

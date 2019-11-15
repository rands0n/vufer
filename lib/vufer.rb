require 'vufer/version'
require 'vufer/configure'
require 'vufer/signature'
require 'vufer/target'

module Vufer
  extend Configure

  class Error < StandardError; end
  class KeyEnvironmentError < Error; end
end

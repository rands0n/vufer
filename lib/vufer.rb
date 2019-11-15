require 'vufer/version'
require 'vufer/configure'
require 'vufer/target'

module Vufer
  extend Configure

  class Error < StandardError; end
end

require 'bundler/setup'
require 'pry'
require 'time'
require 'vufer'

require 'support/vcr'

# Dir[File.join(__dir__, 'spec', 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

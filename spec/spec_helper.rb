require 'rspec'
require 'lumiere'
require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

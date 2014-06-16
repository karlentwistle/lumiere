require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'active_support'
require 'active_support/inflector'

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
    VCR.use_cassette(name, options) { example.call }
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.default_cassette_options = { record: :new_episodes }
end

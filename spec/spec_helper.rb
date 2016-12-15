require 'rest-client'
require 'tophatter_merchant'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

# http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    stub_request(:get, /.*metadata\.json/).to_return(File.new(File.dirname(__FILE__) + '/../tmp/stubs/metadata.json'))
    stub_request(:get, /.*conditions\.json/).to_return(File.new(File.dirname(__FILE__) + '/../tmp/stubs/metadata/conditions.json'))
    stub_request(:get, /.*gemstones\.json/).to_return(File.new(File.dirname(__FILE__) + '/../tmp/stubs/metadata/gemstones.json'))
  end
end

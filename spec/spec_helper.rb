require 'coveralls'
Coveralls.wear!

require 'rest-client'
require 'awesome_print'
require 'tophatter_merchant'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

TophatterMerchant.api_path     = 'http://tophatter.dev/merchant_api/v1'
TophatterMerchant.access_token = 'd8f979fc7d14fec0b075c0b73dbafb59' # megatron@autobot.com

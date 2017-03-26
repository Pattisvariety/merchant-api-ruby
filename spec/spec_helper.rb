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

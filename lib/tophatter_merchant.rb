require 'active_model'

require File.dirname(__FILE__) + '/tophatter_merchant/version'
require File.dirname(__FILE__) + '/tophatter_merchant/exceptions'

# Resources:
require File.dirname(__FILE__) + '/tophatter_merchant/resource'
require File.dirname(__FILE__) + '/tophatter_merchant/account'
require File.dirname(__FILE__) + '/tophatter_merchant/api_key'
require File.dirname(__FILE__) + '/tophatter_merchant/image'
require File.dirname(__FILE__) + '/tophatter_merchant/metadata'
require File.dirname(__FILE__) + '/tophatter_merchant/order'
require File.dirname(__FILE__) + '/tophatter_merchant/product'
require File.dirname(__FILE__) + '/tophatter_merchant/variation'

module TophatterMerchant
  class << self
    attr_accessor :api_path, :access_token, :logging

    def api_path
      @api_path || 'https://tophatter.com/merchant_api/v1'
    end
  end
end

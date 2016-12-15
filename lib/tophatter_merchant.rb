require 'active_model'

module TophatterMerchant
  class << self
    attr_accessor :api_path, :access_token, :logger

    def api_path
      @api_path || 'https://tophatter.com/merchant_api/v1'
    end

    def logger
      unless defined?(@logger)
        @logger = Logger.new(STDOUT)
        @logger.level = Logger::WARN
      end

      @logger
    end
  end
end

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

require 'spec_helper'

# rspec spec/tophatter_merchant/product_spec.rb
describe TophatterMerchant::Product do
  it 'instantiates' do
    product = TophatterMerchant::Product.new({})
    expect(product.persisted?).to be false
  end
end

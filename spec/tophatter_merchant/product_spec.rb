require 'spec_helper'

# rspec spec/tophatter_merchant/product_spec.rb
describe TophatterMerchant::Product do
  before :each do
    TophatterMerchant.api_path = 'http://tophatter.dev/merchant_api/v1'
    TophatterMerchant.access_token = '293da6763df7cb3b894a1831addcb52d'
  end

  describe '.schema' do
    it 'returns the schema', :vcr do
      schema = TophatterMerchant::Product.schema
      expect(schema.find { |component| component['field'] == 'identifier' }['name']).to eq('Unique ID')
    end
  end

  describe '.all' do
    it 'returns all products', :vcr do
      products = TophatterMerchant::Product.all(page: 1, per_page: 5)
      expect(products.length).to be(5)
    end
  end

  describe '.search' do
    it 'returns products matching search terms', :vcr do
      products = TophatterMerchant::Product.search(query: 'Cute', page: 1, per_page: 5)
      expect(products.first.title.include?('Cute')).to be(true)
    end
  end

  describe '.retrieve' do
    it 'retrieves a product', :vcr do
      product = TophatterMerchant::Product.retrieve('PFTBNU5')
      expect(product.identifier).to eq('PFTBNU5')
    end
  end

  describe '.create' do
    it 'creates a product', :vcr do
      product = TophatterMerchant::Product.create(
        identifier: '6631A',
        category: 'Electronics|Hardware (Computers/Tablets/Phones)|Mobile',
        title: 'Apple iPhone 6S',
        description: 'This is the description.',
        condition: 'Refurbished - Manufacturer',
        starting_bid: 1,
        buy_now_price: 150,
        cost_basis: 75,
        shipping_price: 5.0,
        success_fee_bid: 0.5,
        shipping_origin: 'United States',
        weight: 6,
        days_to_fulfill: 3,
        days_to_deliver: 5,
        variations: {
          '6631A-WHITE': {
            identifier: '6631A-WHITE',
            color: 'White', quantity: 1
          },
          '6631A-BLACK': {
            identifier: '6631A-BLACK',
            color: 'Black', quantity: 2
          }
        },
        primary_image: 'https://d38eepresuu519.cloudfront.net/b2aa7d2708324f756ffee551ba43a74f/original.jpg',
        extra_images: 'https://d38eepresuu519.cloudfront.net/e615c55184c06f391dbd768f855904e6/original.jpg|https://d38eepresuu519.cloudfront.net/7cd125f0fa42c965675eabaf3309aa6d/original.jpg'
      )
      expect(product.persisted?).to be(true)
      expect(product.identifier).to eq('6631A')
    end
  end

  describe '.update' do
    it 'updates a product', :vcr do
      product = TophatterMerchant::Product.retrieve('PFTBNU5')
      expect(product.buy_now_price).to eq(399)
      product = TophatterMerchant::Product.update('PFTBNU5', buy_now_price: 100)
      expect(product.buy_now_price).to eq(100)
    end
  end

  describe '.disable' do
    it 'disables a product', :vcr do
      product = TophatterMerchant::Product.enable('PFTBNU5')
      expect(product.disabled_at.nil?).to be(true)
      product = TophatterMerchant::Product.disable('PFTBNU5')
      expect(product.disabled_at.present?).to be(true)
    end
  end

  describe '.enable' do
    it 'enables a product', :vcr do
      product = TophatterMerchant::Product.disable('PFTBNU5')
      expect(product.disabled_at.present?).to be(true)
      product = TophatterMerchant::Product.enable('PFTBNU5')
      expect(product.disabled_at.nil?).to be(true)
    end
  end

  describe '.delete' do
    it 'deletes a product', :vcr do
      product = TophatterMerchant::Product.retrieve('6631A')
      expect(product.deleted_at.nil?).to be(true)
      product = TophatterMerchant::Product.delete('6631A')
      expect(product.deleted_at.present?).to be(true)
    end
  end
end

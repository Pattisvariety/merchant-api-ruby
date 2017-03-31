require 'spec_helper'

# rspec spec/tophatter_merchant/variation_spec.rb
describe TophatterMerchant::Variation do
  describe '.schema', :vcr do
    it 'returns the schema' do
      schema = TophatterMerchant::Variation.schema
      expect(schema.find { |component| component['field'] == 'identifier' }['name']).to eq('Variation Unique ID (SKU)')
    end
  end

  describe '.retrieve' do
    it 'retrieves a variation', :vcr do
      variation = TophatterMerchant::Variation.retrieve('CT1-S')
      expect(variation.identifier).to eq('CT1-S')
      expect(variation.size).to eq('S')
    end
  end

  describe '.create' do
    it 'creates a variation', :vcr do
      variation = TophatterMerchant::Variation.create(
        product_identifier: 'C-T-1',
        identifier: 'CT1-M',
        size: 'M',
        quantity: 99
      )
      expect(variation.identifier).to eq('CT1-M')
      expect(variation.size).to eq('M')
      expect(variation.quantity).to eq(99)
    end
  end

  describe '.update' do
    it 'updates a variation', :vcr do
      variation = TophatterMerchant::Variation.update('CT1-S', quantity: 99)
      expect(variation.quantity).to eq(99)
      variation = TophatterMerchant::Variation.update('CT1-S', quantity: 999)
      expect(variation.quantity).to eq(999)
    end
  end
end

require 'spec_helper'

# rspec spec/tophatter_merchant/order_spec.rb
describe TophatterMerchant::Order do
  describe '.schema', :vcr do
    it 'returns the schema' do
      schema = TophatterMerchant::Order.schema
      expect(schema.find { |component| component['field'] == 'order_id' }['name']).to eq('Order ID')
    end
  end

  describe '.all' do
    it 'returns all orders', :vcr do
      orders = TophatterMerchant::Order.all(filter: 'unfulfilled')
      expect(orders.length).to be(2)
    end
  end

  describe '.retrieve' do
    it 'retrieves an order', :vcr do
      order = TophatterMerchant::Order.retrieve(359887509)
      expect(order.order_id).to eq(359887509)
      expect(order.status).to eq('paid')
      expect(order.product_identifier).to eq('DEFAULT')
      expect(order.customer_id).to eq(981984628)
      expect(order.customer_name).to eq('Optimus Prime')
      expect(order.address1).to eq('201 Valley Street')
      expect(order.city).to eq('Los Altos')
      expect(order.state).to eq('CA')
      expect(order.postal_code).to eq('94022')
      expect(order.country).to eq('United States')
    end
  end

  describe '.fulfill' do
    it 'fulfills an order', :vcr do
      order = TophatterMerchant::Order.fulfill(359887509, carrier: 'USPS', tracking_number: 'CX263292019US')
      expect(order.status).to eq('shipped')
      expect(order.carrier).to eq('usps')
      expect(order.tracking_number).to eq('CX263292019US')
    end
  end

  describe '.refund' do
    it 'refunds an order', :vcr do
      order = TophatterMerchant::Order.refund(359887509, type: 'partial', reason: 'delay_in_shipping', fees: ['shipping_fee'])
      expect(order.available_refunds).to eq('buyer_fee' => 399.0)
    end
  end
end

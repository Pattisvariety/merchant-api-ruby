module TophatterMerchant
  class Order < Resource
    attr_accessor :order_id, :status
    attr_accessor :carrier, :tracking_number
    attr_accessor :product_name, :product_identifier, :variation_identifier
    attr_accessor :customer_name, :address1, :address2, :city, :state, :postal_code, :country
    attr_accessor :available_refunds, :refund_amount
    attr_accessor :disbursement_amount, :seller_fees_amount, :seller_fees
    attr_accessor :paid_at, :created_at

    class << self
      # ap TophatterMerchant::Order.schema
      def schema
        get(url: "#{path}/schema.json")
      end

      # ap TophatterMerchant::Order.all.map(&:to_h)
      # ap TophatterMerchant::Order.all(filter: 'unfulfilled').map(&:to_h)
      # ap TophatterMerchant::Order.all(filter: 'fulfilled').map(&:to_h)
      def all(filter: nil, page: 1, per_page: 50)
        get(url: "#{path}.json", params: { filter: filter, page: page, per_page: per_page }).map do |hash|
          Order.new(hash)
        end
      end

      # ap TophatterMerchant::Order.retrieve(681195262).to_h
      def retrieve(id)
        Order.new get(url: "#{path}/retrieve.json", params: { order_id: id })
      end

      # ap TophatterMerchant::Order.fulfill(417953232, carrier: 'other', tracking_number: 'ABC123').to_h
      def fulfill(id, carrier:, tracking_number:)
        Order.new post(url: "#{path}/fulfill.json", params: { order_id: id, carrier: carrier, tracking_number: tracking_number })
      end

      def unfulfill(id)
        post(url: "#{path}/#{id}/unfulfill.json")
      end

      # ap TophatterMerchant::Order.refund(417953232, type: 'full', reason: 'delay_in_shipping').to_h
      # ap TophatterMerchant::Order.refund(417953232, type: 'partial', reason: 'other', fees: ['shipping_fee']).to_h
      def refund(id, type:, reason:, fees: [])
        Order.new post(url: "#{path}/refund.json", params: { order_id: id, type: type, reason: reason, fees: fees })
      end

      protected

      def path
        super + '/orders'
      end
    end
  end
end

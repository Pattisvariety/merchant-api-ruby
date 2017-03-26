module TophatterMerchant
  class Variation < Resource
    attr_accessor :product_identifier, :identifier,
                  :size, :color, :quantity,
                  :created_at, :disabled_at, :deleted_at

    def id
      created_at.present? ? identifier : nil
    end

    class << self
      # ap TophatterMerchant::Variation.schema
      def schema
        get(url: "#{path}/schema.json")
      end

      # ap TophatterMerchant::Variation.retrieve('FOOBAR-R').to_h
      def retrieve(identifier)
        Variation.new get(url: "#{path}/retrieve.json", params: { identifier: identifier })
      end

      # ap Variation.create(product_identifier: '6631A', identifier: '6631A-GRAY', color: 'Gray', quantity: 33).to_h
      def create(params)
        Variation.new post(url: "#{path}.json", params: params)
      end

      # ap TophatterMerchant::Variation.update('FOOBAR-R', quantity: 100).to_h
      def update(identifier, data)
        Variation.new post(url: "#{path}/update.json", params: data.merge(identifier: identifier))
      end

      protected

      def path
        super + '/variations'
      end
    end
  end
end

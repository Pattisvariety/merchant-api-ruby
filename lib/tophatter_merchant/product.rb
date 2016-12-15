module TophatterMerchant
  class Product < Resource
    attr_accessor :identifier,
                  :category, :title, :description, # Basics
                  :condition, :brand, :material, # Facets
                  :available_quantity, :variations, # Variations
                  :starting_bid, :buy_now_price, :retail_price, :cost_basis, :minimum_alerts_needed, # Pricing
                  :shipping_origin, :shipping_price, :expedited_shipping_price, :days_to_fulfill, :days_to_deliver, :expedited_days_to_deliver, :weight, # Shipping
                  :buy_one_get_one_price, :accessory_price, :accessory_description, # Upsells
                  :primary_image, :extra_images, :all_images, # Images
                  :slug, :ratings_average, :ratings_count, # Ratings
                  :created_at, :updated_at, :disabled_at, :deleted_at, # Timestamps
                  :blacklisted_at, :admin_hold_at, :slug, :internal_id # Other

    def id
      created_at.present? ? identifier : nil
    end

    # Available: thumbnail, square, medium, large, original.
    def images(size: 'square')
      if persisted?
        all_images.collect { |image| image[size] }
      else
        ([primary_image] + extra_images.to_s.split('|')).compact
      end
    end

    def copy
      hash = to_h

      # Delete the keys that shouldn't be copied.
      %w(identifier primary_image extra_images all_images ratings_average ratings_count created_at updated_at disabled_at deleted_at blacklisted_at slug admin_hold_at).each do |key|
        hash.delete(key)
        hash['variations'].each { |variation| variation.delete(key) }
      end

      Product.new(hash)
    end

    def to_param
      slug || identifier
    end

    class << self
      # ap TophatterMerchant::Product.schema
      def schema
        get(url: "#{path}/schema.json")
      end

      def search(query:, page: 1, per_page: 50, pagination: nil)
        result = get(url: "#{path}/search.json", params: { query: query, page: page, per_page: per_page, pagination: pagination })

        if pagination.present?
          result['results'] = result['results'].map { |hash| Product.new(hash) }
        else
          result.map { |hash| Product.new(hash) }
        end

        result
      end

      # ap TophatterMerchant::Product.all.map(&:to_h)
      def all(status: nil, category: nil, page: 1, per_page: 50, pagination: nil, sort: nil)
        result = get(url: "#{path}.json", params: { status: status, category: category, page: page, per_page: per_page, pagination: pagination, sort: sort })

        if pagination.present?
          result['results'] = result['results'].map { |hash| Product.new(hash) }
        else
          result = result.map { |hash| Product.new(hash) }
        end

        result
      end

      def retrieve(id)
        Product.new get(url: "#{path}/retrieve.json", params: { identifier: id })
      end

      # ap TophatterMerchant::Product.create(TophatterMerchant::Product.new({}).fill!.to_h).to_h
      def create(data)
        Product.new post(url: "#{path}.json", params: data)
      end

      # ap TophatterMerchant::Product.update('FOOBAR', buy_now_price: 11).to_h
      def update(id, data)
        Product.new post(url: "#{path}/update.json", params: data.merge(identifier: id))
      end

      # ap TophatterMerchant::Product.delete('FOOBAR').to_h
      def delete(id)
        Product.new post(url: "#{path}/delete.json", params: { identifier: id })
      end

      # ap TophatterMerchant::Product.disable('FOOBAR').to_h
      def disable(id)
        Product.new post(url: "#{path}/disable.json", params: { identifier: id })
      end

      # ap TophatterMerchant::Product.enable('FOOBAR').to_h
      def enable(id)
        Product.new post(url: "#{path}/enable.json", params: { identifier: id })
      end

      def upload(file, template:)
        Product.new post(url: "#{path}/upload.json", params: { file: file, template: template })
      end

      protected

      def path
        super + '/products'
      end
    end
  end
end

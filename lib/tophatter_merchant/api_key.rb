module TophatterMerchant
  class ApiKey < Resource

    attr_accessor :id, :access_token, :created_at

    class << self

      # ap TophatterMerchant::ApiKey.schema
      def schema
        get(url: "#{path}/schema.json")
      end

      # ap TophatterMerchant::ApiKey.all.map(&:to_h)
      def all
        get(url: "#{path}.json").map do |hash|
          ApiKey.new(hash)
        end
      end

      # ap TophatterMerchant::ApiKey.retrieve(1).to_h
      def retrieve(id)
        ApiKey.new get(url: "#{path}/#{id}.json")
      end

      # ap TophatterMerchant::ApiKey.create.to_h
      def create
        ApiKey.new post(url: "#{path}.json")
      end

      # ap TophatterMerchant::ApiKey.destroy(TophatterMerchant::ApiKey.all.last.id).map(&:to_h)
      def destroy(id)
        delete(url: "#{path}/#{id}.json").map do |hash|
          ApiKey.new(hash)
        end
      end

      protected

      def path
        super + '/api_keys'
      end

    end
  end
end

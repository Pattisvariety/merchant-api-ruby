module TophatterMerchant
  class Metadata < Resource
    class << self

      # ap TophatterMerchant::Metadata.all
      def all
        get(url: "#{path}.json")
      end

      # ap TophatterMerchant::Metadata.conditions
      def conditions
        get(url: "#{path}/conditions.json")
      end

      # ap TophatterMerchant::Metadata.categories
      def categories
        get(url: "#{path}/categories.json")
      end

      # ap TophatterMerchant::Metadata.sizes
      def sizes
        get(url: "#{path}/sizes.json")
      end

      # ap TophatterMerchant::Metadata.countries
      def countries
        get(url: "#{path}/countries.json")
      end

      # ap TophatterMerchant::Metadata.country_codes
      def country_codes
        get(url: "#{path}/country_codes.json")
      end

      # ap TophatterMerchant::Metadata.states
      def states
        get(url: "#{path}/states.json")
      end

      # ap TophatterMerchant::Metadata.provinces
      def provinces
        get(url: "#{path}/provinces.json")
      end

      # ap TophatterMerchant::Metadata.territories
      def territories
        get(url: "#{path}/territories.json")
      end

      # ap TophatterMerchant::Metadata.carriers
      def carriers
        get(url: "#{path}/carriers.json")
      end

      protected

      def path
        super + '/metadata'
      end

    end
  end
end

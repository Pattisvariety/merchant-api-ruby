module TophatterMerchant
  class Account < Resource
    attr_accessor :access_token, :first_name, :last_name, :store_name, :email, :country, :time_zone

    def id
      email
    end

    class << self
      # ap TophatterMerchant::Account.schema
      def schema
        get(url: "#{path}/schema.json")
      end

      # ap TophatterMerchant::Account.authenticate(email: 'megatron@autobot.com', password: 'ipipip').to_h
      def authenticate(email:, password:)
        Account.new post(url: "#{path}/authenticate.json", params: { email: email, password: password })
      end

      # ap TophatterMerchant::Account.me.to_h
      def me
        Account.new get(url: "#{path}/me.json")
      end

      # ap TophatterMerchant::Account.create(first_name: 'Foo', last_name: 'Bar', store_name: 'Foo Bar, Inc', email: 'foo@bar.com', password: 'ipipip', country: 'United States', time_zone: 'Pacific Time (US & Canada)').to_h
      def create(data)
        Account.new post(url: "#{path}.json", params: data)
      end

      # Change first & last name:
      # ap TophatterMerchant::Account.update(first_name: 'Mega', last_name: 'Tron').to_h
      # Change password:
      # ap TophatterMerchant::Account.update(password: 'qwer1234').to_h
      # ap TophatterMerchant::Account.authenticate(email: 'megatron@autobot.com', password: 'qwer1234').to_h
      # ap TophatterMerchant::Account.update(password: 'ipipip').to_h
      def update(data)
        Account.new post(url: "#{path}/update.json", params: data)
      end

      protected

      def path
        super + '/account'
      end
    end
  end
end

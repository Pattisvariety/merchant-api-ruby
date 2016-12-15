require 'active_model'

module TophatterMerchant
  class Resource
    include ActiveModel::Model

    def initialize(hash)
      # Only honor valid attributes.
      hash.each do |key, value|
        if respond_to?("#{key}=")
          send("#{key}=", value)
        else
          TophatterMerchant.logger.warn "Invalid attribute #{key} specified for #{self.class.name}"
        end
      end
    end

    def persisted?
      id.present? # @TODO: Should this be internal_id?
    end

    def to_h
      self.class.attributes.map { |key| [key, send(key)] }.to_h
    end

    class << self
      def attr_accessor(*vars)
        # TophatterMerchant.logger.debug "#{name}: #{vars.inspect} (attr_accessor)"
        @attributes ||= {}
        vars.each { |var| @attributes[var.to_s] = true }
        super(*vars)
      end

      def attributes
        @attributes ||= {}
        @attributes.keys
      end

      protected

      def get(url:, params: {})
        execute request(method: :get, url: url, params: params)
      end

      def post(url:, params: {})
        execute request(method: :post, url: url, params: params)
      end

      def put(url:, params: {})
        execute request(method: :put, url: url, params: params)
      end

      def delete(url:, params: {})
        execute request(method: :delete, url: url, params: params)
      end

      def execute(request)
        TophatterMerchant.logger.debug "#{request.method.upcase} #{request.url} #{request.payload.inspect}"
        response = request.execute
        raise BadContentTypeException.new, "The server didn't return JSON. You probably made a bad request." if response.headers[:content_type] == 'text/html; charset=utf-8'
        JSON.parse(response.body)
      rescue RestClient::Request::Unauthorized, RestClient::Forbidden => e
        TophatterMerchant.logger.debug "#{e.class.name}: #{e.response.code} -> raising UnauthorizedException"
        raise UnauthorizedException.new, parse_error(e, e.message)
      rescue RestClient::ResourceNotFound => e
        TophatterMerchant.logger.debug "#{e.class.name}: #{e.response.code} -> raising NotFoundException"
        raise NotFoundException.new, parse_error(e, 'The API path you requested does not exist.')
      rescue RestClient::BadRequest => e
        TophatterMerchant.logger.debug "#{e.class.name}: #{e.response.code} -> raising BadRequestException"
        raise BadRequestException.new, parse_error(e, e.message)
      rescue RestClient::InternalServerError => e
        TophatterMerchant.logger.debug "#{e.class.name}: #{e.response.code} -> raising ServerErrorException"
        raise ServerErrorException.new, parse_error(e, 'The server encountered an internal error. This is probably a bug, and you should contact support.')
      end

      def request(method:, url:, params:)
        payload = if TophatterMerchant.access_token.present?
          params.merge(access_token: TophatterMerchant.access_token)
        else
          params
        end

        RestClient::Request.new(method: method, url: url, payload: payload, accept: :json)
      end

      def path
        TophatterMerchant.api_path
      end

      private

      def parse_error(exception, fallback)
        error = begin
          JSON.parse(exception.response)
        rescue
          {}
        end

        error['message'] || fallback
      end
    end
  end
end

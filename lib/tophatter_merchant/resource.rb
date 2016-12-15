require 'active_model'

module TophatterMerchant
  class Resource
    include ActiveModel::Model

    def self.attr_accessor(*vars)
      attributes!(*vars)
      super(*vars)
    end

    def initialize(hash)
      self.attributes = hash
    end

    def attributes=(hash)
      hash.each do |key, value|
        if respond_to?(key)
          self.class.attributes!(key)
          send("#{key}=", value)
        end
      end
    end

    def to_h
      self.class.attributes.keys.collect { |key| [key, send(key)] }.to_h
    end

    def persisted?
      id.present?
    end

    def log(message)
      self.class.log(message)
    end

    class << self
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
        log "#{request.method.upcase} #{request.url} #{request.payload.inspect}"
        response = request.execute
        raise BadContentTypeException.new, "The server didn't return JSON. You probably made a bad request." if response.headers[:content_type] == 'text/html; charset=utf-8'
        JSON.parse(response.body)
      rescue RestClient::Request::Unauthorized, RestClient::Forbidden => e
        log "#{e.class.name}: #{e.response.code} -> raising UnauthorizedException"
        raise UnauthorizedException.new, parse_error(e, e.message)
      rescue RestClient::ResourceNotFound => e
        log "#{e.class.name}: #{e.response.code} -> raising NotFoundException"
        raise NotFoundException.new, parse_error(e, 'The API path you requested does not exist.')
      rescue RestClient::BadRequest => e
        log "#{e.class.name}: #{e.response.code} -> raising BadRequestException"
        raise BadRequestException.new, parse_error(e, e.message)
      rescue RestClient::InternalServerError => e
        log "#{e.class.name}: #{e.response.code} -> raising ServerErrorException"
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

      def attributes
        @attributes || {}
      end

      def attributes!(*vars)
        @attributes ||= {}
        vars.map(&:to_s).each { |var| @attributes[var] = true }
        @attributes
      end

      def parse_error(exception, fallback)
        error = begin
          JSON.parse(exception.response)
        rescue
          {}
        end

        error['message'] || fallback
      end

      def log(message)
        puts message if TophatterMerchant.logging
      end
    end
  end
end

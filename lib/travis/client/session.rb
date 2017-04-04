# frozen_string_literal: true
module Travis::Client
  class Session
    LINK_ATTRIBUTES = %w[@href offset limit]
    private_constant :LINK_ATTRIBUTES

    attr_reader :connection, :response_cache, :request_headers

    def initialize(connection, access_token: nil, request_headers: {})
      @connection                       = connection
      @http_connections                 = {}
      @response_cache                   = {}
      @request_headers                  = connection.request_headers.merge(request_headers)
      @request_headers['Authorization'] = "token #{access_token}" if access_token
    end

    def inspect
      "#<#{Session}>"
    end

    def request(method, uri, params = {})
      method         = method.to_s.upcase
      options        = {}
      options[:json] = params if params.any?
      uri            = Addressable::URI.parse(uri) unless uri.is_a? Addressable::URI
      response       = connection.notify(method, uri, params) { http_connection(uri).request(method, uri, options) }
      payload        = JSON.load(response.body)
      wrap(payload, uri)
    end

    def call(resource_type, action_name, variables = {})
      action(resource_type, action_name).call(self, variables)
    end

    def error_types
      # we currently don't allow/need to override error types
      connection.error_types
    end

    def resource_types
      return @resource_types if defined? @resource_types and @resource_types
      connection.resource_types
    end

    def set_default_types
      @resource_types ||= connection.resource_types.map { |k,v| [k,v.for_session(self)] }.to_h
    end

    def define_constants(container)
      set_default_types
      error_types.merge(resource_types).each do |key, factory|
        constant = key.split('_').map(&:capitalize).join
        container.const_set(constant, factory) unless container.const_defined?(constant, false)
      end
      container.extend connection.mixin
      container
    end

    def fetch(link)
      response_cache.fetch(link) { request('GET', link) }
    end

    private def session
      self
    end

    private def http_connection(uri)
      raise ArgumentError, 'request URI needs to be absolute' unless uri.absolute?
      @http_connections[uri.authority] ||= connection.http_factory.persistent(uri.join('/')).headers(request_headers)
    end

    private def wrap(payload, uri)
      case payload
      when Array then payload.map { |e| wrap(e, uri) }
      when Hash  then load(payload.map { |k,v| [k, wrap(v, uri)] }.to_h, uri)
      else payload
      end
    end

    private def load(payload, uri)
      return payload unless payload['@type'] or payload['@href']

      if payload['@type'] == 'error'
        factory = error_types.fetch(payload['error_type']) { resource_types.fetch('error', Error) }
        error   = factory.new(self, payload['error_message'] || factory.default_message)
        error.merge! payload
        raise error
      end

      if payload['@href']
        href    = uri.join(payload['@href'])
        return response_cache[href] || Link.new(self, href, payload) if payload.all? { |a, _| LINK_ATTRIBUTES.include?(a) }
        current = response_cache[href]
      end

      current ||= resource_types.fetch(payload['@type'], Unknown).new(self, href)
      current.merge! payload
      response_cache[href] = current
    end
  end
end

require 'tmpdir'
require 'addressable/uri'
require 'http'
require 'logger'
require 'travis/client/constants/resources'
require 'travis/client/helper'
require 'travis/client/index'
require 'travis/client/resource/factory'
require 'travis/client/version'

module Travis
  module Client
    class Session
      include Helper::Hash

      attr_reader :cache, :connections, :endpoint, :headers, :token, :http, :path, :namespace

      HEADERS = {
        'Travis-API-Version' => '3',
        'Accept' => 'application/json',
        'User-Agent' => "Travis/#{VERSION} Ruby/#{RUBY_VERSION}"
      }

      def initialize(endpoint: nil, headers: {}, token: nil, path: nil, http: HTTP)
        @endpoint = Addressable::URI.parse(endpoint || Client.default_endpoint)
        @headers = HEADERS.merge(headers)
        @headers['Authorization'] = "token #{token}" if token
        @token = token
        @http = http
        @path = path ||= Dir.tmpdir
        @cache = {}
        @connections = {}
        namespace
      end

      def notify(*)
        yield
      end

      def config
        index.config
      end

      def fetch(uri, params = {}, opts = {})
        request(:GET, uri, params, opts)
      end

      def request(method, uri, params = {}, opts = {})
        uri = to_uri(uri)
        method = method.to_s.upcase
        params = { json: params } if params.any?
        headers = self.headers.merge(opts[:headers] || {})
        logger = Logger.new($stdout)

        response = notify(method, uri, params) do
          # .use(logging: { logger: Logger.new($stdout) })
          connection(uri).headers(headers).request(method, uri, params)
        end

        # TODO error handling?

        return if response.code == 204
        data = symbolize(JSON.parse(response.body))
        data = Resource::Factory.wrap(self, uri, data, opts) unless opts[:load].is_a?(FalseClass)
        data
      end

      def index
        @index ||= Index.new(self, path: path)
      end

      def namespace
        @namespace ||= Resources.namespace(index.hash) || Constants::Resources.new(index).define
      end

      private

        def connection(uri)
          connections[uri] ||= http.persistent(uri.join('/'))
        end

        def to_uri(uri)
          uri = Addressable::URI.parse(uri) unless uri.is_a?(Addressable::URI)
          uri = endpoint.join(uri) unless uri.absolute?
          uri
        end
    end
  end
end

require 'net/http'
require 'json'
require 'faraday'
require 'travis/api/client/repositories'

module Travis

  module API

    # Travis API Client

    class Client

      def initialize(options = {})
        @options = {:format => DEFAULT_FORMAT}.merge(options)
      end

      # Sets the response format and returns the host client instance
      #
      # @param [Symbol, String] format The desired response format, <tt>:json</tt>.
      # @return [Client, Client::Repositories] The host client instance.
      def format(format)
        @options[:format] = format.to_s
        self
      end

      def self.method_missing(method, *args, &block)
        return self.new.send(method, *args, &block) if self.client.respond_to?(method)
        super
      end

      def self.respond_to?(method, include_private = false)
        self.client.respond_to?(method, include_private) || super(method, include_private)
      end	

    private
       
      # Client default host
      API_HOST = 'http://travis-ci.org'

      # Response default format
      DEFAULT_FORMAT = 'json'

      # Returns the HTTP connection handler
      #
      # @return [Faraday] 
      def connection
        @@connection ||= Faraday.new(:url => API_HOST) do |builder|
          builder.adapter  :net_http
        end
      end
     
      # Returns the encoded response for the given path and previouly set options
      #
      # @param [String] path API target path
      # @return Encoded response
      def results_for(path_template)
        path = path_template.dup

        @options.each_pair do |key, value|
          path.gsub!(":#{key}", value)
        end

        response = connection().get(path)
        
        return response.status == 200 ? parse(response.body) : nil
      end

      # Encodes and return the given content based on the previously set format
      #
      # @param [String] content Content to be encoded
      # @return Encoded conter
      def parse(content)
        case @options[:format]
        when 'json' then
          return JSON.parse(content)
        when 'xml'
          return REXML::Document.new(content)
        end
      end

 
      # Initializes and return an instance of the current class
      #
      # @return A new instance of the current class
      def self.client
        self.new
      end

    end

  end

end


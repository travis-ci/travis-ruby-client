require 'net/http'
require 'json'
require 'travis/api/client/repositories'

module Travis

  module API

    # Travis CI API Client

    class Client

      def initialize(options={})
        @options = {:format=>DEFAULT_FORMAT}.merge(options)
      end

      #Since right now we are not supporting a raw response the format doesn't make any sence 
      #
      #def format(format)
      #  @options[:format] = format.to_s
      #  self
      #end

      def self.method_missing(method, *args, &block)
        return self.new.send(method, *args, &block) if self.client.respond_to?(method)
        super
      end

      def self.respond_to?(method, include_private=false)
        self.client.respond_to?(method, include_private) || super(method, include_private)
      end	

    private
       
      # Client default configuration
      # TODO: Move to a configuration file?
      
      API_HOST = 'travis-ci.org'
      DEFAULT_FORMAT = 'json'
     
      # Returns the encoded response for the given path and 
      # previouly set options

      def results_for(path)
        @options.each_pair do |key, value|
          path.gsub!(":#{key}", value)
        end

        #TODO Add proxy support / Faraday instead
        response = Net::HTTP.get_response(API_HOST, path)

        return parse(response.body)
      end

      # Encodes and return the given content
      # based on the previously set format

      def parse(content)
        case @options[:format]
        when 'json' then
          return JSON.parse(content)
        when 'xml'
          return REXML::Document.new(content)
        end
      end

      # Returns a new instance of the current class
 
      def self.client
        self.new
      end

    end

  end

end


module Support
  class FakeHTTP
    Response = Struct.new(:body)
    def self.new(directory = 'default')
      @instances            ||= {}
      @instances[directory] ||= super
    end

    def initialize(directory)
      @headers   = {}
      @endpoints = []
      Dir.glob("#{__dir__}/../http_responses/#{directory}/**.http").sort.each { |file| self << File.read(file) }
    end

    def <<(raw_http)
      entries = raw_http.gsub("\n", "\r\n").split(%r{(?=^HTTP/1.1)})
      return unless entries.size == 2

      @endpoints << entries.map do |raw|
        parser         = HTTP::Parser.new
        body           = ""
        parser.on_body = proc { |chunk| body << chunk }
        parser << raw
        [parser, body]
      end
    end

    def request(method, uri, options = {})
      # TODO: options
      response, body = response_for(method, uri, @headers)
      Response.new(body)
    end

    def response_for(method, uri, headers)
      @endpoints.each do |(request, request_body), (response, response_body)|
        next unless request.http_method == method.to_s.upcase
        next unless request.request_url == uri.to_s
        next unless request.headers.all? { |k, v| headers[k] == v }
        return [response, response_body]
      end

      raise RuntimeError, "could not find matching request: #{method} #{uri}"
    end

    def persistent(uri)
      self
    end

    def headers(headers = {})
      @headers = headers
      self
    end
  end
end

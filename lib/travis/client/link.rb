# frozen_string_literal: true
module Travis::Client
  class Link
    attr_reader :session, :href

    def initialize(session, href, payload = {})
      @session, @href, @payload = session, href, payload
    end

    def to_entity
      fetch
    end

    def fetch
      session.fetch(href)
    end

    def to_h
      @payload.dup
    end

    def offset
      @payload['offset']
    end

    def limit
      @payload['limit']
    end

    def inspect
      "#<%p:%p>" % [ self.class, href.omit(:scheme, :authority).to_s ]
    end
  end
end

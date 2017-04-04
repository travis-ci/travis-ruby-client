# frozen_string_literal: true
module Travis::Client
  class Collection < Entity
    include Enumerable

    def paginates?
      !!@payload['@pagination']
    end

    def offset
      pagination_info['offset'] || 0
    end

    def on_page
      @on_page ||= Array(@payload[collection_key])
    end

    def last_page?
      pagination_info.fetch('is_last', true)
    end

    def first_page?
      pagination_info.fetch('is_first', true)
    end

    def collection_key
      @collection_key ||= begin
        session.fetch(@href) if @payload.keys.all? { |k| k.start_with? '@' }
        @payload.keys.detect { |k| !k.start_with?('@') and self[k].is_a? Array }
      end
    end

    def size
      pagination_info['count'] || on_page.size
    end

    def next_page
      pagination_info['next']&.fetch
    end

    def previous_page
      pagination_info['prev']&.fetch
    end

    def first_page
      return self if first_page?
      pagination_info['first']&.fetch
    end

    def last_page
      return self if last_page?
      pagination_info['last']&.fetch
    end

    def each(&block)
      return enum_for(:each) unless block
      on_page.each(&block)
      next_page&.each(&block)
      self
    end

    def pagination_info
      @pagination_info ||= @payload['@pagination'] || {}
    end
  end
end

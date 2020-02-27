module Travis
  module Client
    module Resource
      class Link < Struct.new(:session, :href, :data)
        ATTRS = %i(@href offset limit)

        def fetch(opts = {})
          session.fetch(href, {}, opts)
        end

        def to_h
          data.dup
        end

        def offset
          data[:offset]
        end

        def limit
          data[:limit]
        end

        def data
          @data ||= super || {}
        end

        def inspect
          "#<%p:%p>" % [self.class, href.omit(:scheme, :authority).to_s]
        end
      end
    end
  end
end

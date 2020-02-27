require 'travis/client/resource/link'

module Travis
  module Client
    module Resource
      class Entity < Struct.new(:session, :href, :data, :opts)
        def [](key)
          key = key.to_sym
          load(key) if load?(key)
          result = data[key]
          result = result.fetch if result.is_a?(Link)
          result
        end

        def load?(key)
          type && !known?(key)
        end

        def load(key)
          href = self.href.dup
          href.query_values = { include: "#{type}.#{key}" }
          session.fetch(href)
        end

        def type
          data[:@type]
        end

        def known?(key)
          data.key?(key)
        end

        def permission?(key)
          Hash(self[:@permissions])[key.to_sym]
        end

        def data
          @data ||= super || {}
        end

        def serialize(obj = self)
          case obj
          when Entity
            serialize(obj.data)
          when Hash
            obj.map { |key, obj| [key, serialize(obj)] }.to_h
          when Array
            obj.map { |obj| serialize(obj) }
          else
            obj
          end
        end
        alias to_h serialize
      end
    end
  end
end

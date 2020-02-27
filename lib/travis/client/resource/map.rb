require 'forwardable'

module Travis
  module Client
    module Resource
      class Params
        class Map < Struct.new(:subject, :params)
          extend Forwardable

          def_delegators :subject, :resource, :all, :known?, :path?, :body?

          def to_h
            params.map { |key, value| map(key.to_s, value) }.inject(&:merge) || {}
          end

          private

            def map(key, value)
              if value.nil?
                {}
              elsif prefix?(key)
                prefix(key, value)
              elsif entity?(value)
                entity(key, value)
              elsif hash?(key, value)
                hash(key, value)
              elsif path?(key)
                path(key, value)
              else
                { key => value }
              end
            end

            def prefix?(key)
              !known?(key) and known?("#{resource}.#{key}")
            end

            def prefix(key, value)
              map("#{resource}.#{key}", value)
            end

            def hash?(key, value)
              value.is_a?(Hash) && !body?(key)
            end

            def hash(key, value)
              value.map { |key, value| map(key, value) }.inject(&:merge) || {}
            end

            def entity?(value)
              value.is_a?(Resource::Entity)
            end

            def entity(key, obj)
              all.inject({}) do |params, param|
                next params unless param =~ /^#{key}\.(.+)$/ and obj.respond_to?($1)
                params.merge(param => obj.public_send($1))
              end
            end

            def path(key, value)
              { key => value.is_a?(Array) ? value.join(',') : value }
            end
        end
      end
    end
  end
end

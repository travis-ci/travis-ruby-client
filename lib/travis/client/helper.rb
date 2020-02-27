module Travis
  module Client
    module Helper
      module Hash
        def compact(hash)
          hash.reject { |_, value| value.nil? }
        end

        def only(hash, *keys)
          hash.select { |key, _| keys.include?(key) }
        end

        def except(hash, *keys)
          hash.reject { |key, _| keys.include?(key) }
        end

        def symbolize(obj)
          case obj
          when ::Hash
            obj.map { |key, obj| [key.to_sym, symbolize(obj)] }.to_h
          when Array
            obj.map { |obj| symbolize(obj) }
          else
            obj
          end
        end

        def stringify(obj)
          case obj
          when ::Hash
            obj.map { |key, obj| [key.to_s, stringify(obj)] }.to_h
          when Array
            obj.map { |obj| stringify(obj) }
          else
            obj
          end
        end
      end

      module String
        def camelize(string)
          string.to_s.split('_').map(&:capitalize).join
        end
      end
    end
  end
end

require 'travis/client/resource/error'
require 'travis/client/resource/link'
require 'travis/client/resource/unknown'
require 'travis/client/resources'

module Travis
  module Client
    module Resource
      class Factory < Struct.new(:session, :uri, :data, :opts)
        def self.wrap(session, uri, obj, opts)
          case obj
          when Array
            obj.map { |obj| wrap(session, uri, obj, opts) }
          when Hash
            obj = obj.map { |key, obj| [key, wrap(session, uri, obj, opts)] }.to_h
            new(session, uri, obj, opts).load
          else
            obj
          end
        end

        def load
          if type.nil? && href.nil?
            data
          elsif error?
            error
          elsif link?
            link
          else
            resource
          end
        end

        def type
          data[:@type]
        end

        def href
          @href ||= uri.join(data[:@href]) if data[:@href]
        end

        def resource
          const = namespace[type] || Unknown
          curr = if href
            cache[href] ||= const.new(session, href, nil, opts)
          else
            # should never happen, right? but it does, e.g. on builds.commit
            const.new(session, href, nil, opts)
          end
          curr.data.update(data)
          curr
        end

        def link?
          data.all? { |a, _| Link::ATTRS.include?(a) }
        end

        def link
          cache[href] || Link.new(session, href, data)
        end

        def error?
          type == 'error'
        end

        def error
          const = namespace.lookup(data[:error_type]) || namespace[:error] || Error
          error = const.new(data[:error_message])
          raise error
        end

        def cache
          session.cache
        end

        def namespace
          session.namespace
        end
      end
    end
  end
end

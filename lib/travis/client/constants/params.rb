require 'travis/client/resource/params'

module Travis
  module Client
    module Constants
      class Params < Struct.new(:resource, :method, :template, :body)
        attr_reader :required, :optional

        def initialize(*)
          super
          @required, @optional = parse(template)
        end

        def define
          const = Class.new(Resource::Params)
          const.definition = Definition::Params.new(resource, method, required, optional, body)
          const
        end

        def parse(pattern)
          pattern.scan(/\{(\W?)(?:([^\}]+))\}/).inject([[], []]) do |result, (prefix, params)|
            result.send(prefix == '?' ? :last : :first).concat(params.split(','))
            result
          end
        end
      end
    end
  end
end

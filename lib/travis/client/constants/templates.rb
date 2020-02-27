require 'travis/client/constants/params'
require 'travis/client/resource/template'

module Travis
  module Client
    module Constants
      class Templates < Struct.new(:resource, :definitions)
        METHODS = %i(GET PATCH DELETE PUT POST)

        def define
          sort(templates)
        end

        private

          def templates
            definitions.map do |definition|
              Template.new(resource, definition).define
            end
          end

          def sort(templates)
            templates.sort_by do |t|
              [
                METHODS.index(t.definition.method) || METHODS.size,
                -t.definition.required.size,
                t.definition.optional.size
              ]
            end
          end
      end

      class Template < Struct.new(:resource, :definition)
        attr_reader :required, :optional

        def initialize(*)
          super
          @required, @optional = parse(definition[:uri_template])
        end

        def define
          const = Class.new(Resource::Template)
          params = Params.new(resource, method, template, body).define
          const.definition = Definition::Template.new(resource, method, required, optional, template, params)
          const
          # const.const_set(:RESOURCE, resource)
          # const.const_set(:METHOD, method)
          # const.const_set(:REQUIRED, required)
          # const.const_set(:OPTIONAL, optional)
          # const.const_set(:TEMPLATE, template)
          # const.const_set(:Params, )
          # const
        end

        private

          def method
            definition[:request_method].to_sym
          end

          def template
            definition[:uri_template]
          end

          def body
            Array(definition[:accepted_params])
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

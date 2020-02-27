require 'travis/client/resource/params'

module Travis
  module Client
    module Resource
      class Template < Struct.new(:params)
        singleton_class.send(:attr_accessor, :definition)

        %i(resource method required optional body).each do |key|
          define_method(key) { self.class.definition.send(key) }
        end

        def accept?
          params.accept?
        end

        def uri
          template.expand(params.params)
        end

        def template
          @template ||= Addressable::Template.new(self.class.definition.template)
        end

        def payload
          params.payload
        end

        def possible_params
          params.possible_params
        end

        def accepted_types
          types = required.map(&:to_s)
          types.map { |key| key.split('.').first if key.include?('.') }.compact
        end

        def params
          @params ||= self.class.definition.params.new(super)
        end

        def to_s
          [method, template.pattern].join(' ')
        end
      end
    end
  end
end

require 'travis/client/resource/map'

module Travis
  module Client
    module Resource
      class Params
        attr_reader :params

        singleton_class.send(:attr_accessor, :definition)

        def initialize(params)
          @params = Map.new(self, params).to_h
        end

        %i(resource method required optional).each do |key|
          define_method(key) { self.class.definition.send(key) }
        end

        def body
          self.class.definition.body.map(&:to_s)
        end

        def accept?
          return false unless required.all? { |key| params.key?(key) }
          accept_all? or params.keys.all? { |key| known?(key) }
        end

        def all
          @all ||= required + optional + body
        end

        def known?(key)
          all.include?(key)
        end

        def path?(key)
          required?(key) or optional?(key)
        end

        def required?(key)
          required.include?(key)
        end

        def optional?(key)
          optional.include?(key)
        end

        def body?(key)
          body.include?(key)
        end

        def payload
          params.reject { |key, _| path?(key) }
        end

        def possible_params
          params = [required, optional + body]
          params = params.map { |params| params.map { |key| strip_prefix(key).inspect }.join(', ') if params.any? }
          params.compact.join(', optionally ')
        end

        private

          def accept_all?
            method != 'GET' and body.empty?
          end

          def strip_prefix(key)
            key.sub(/^#{resource}\./, '').to_sym
          end
      end
    end
  end
end

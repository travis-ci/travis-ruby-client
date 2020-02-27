require 'travis/client/constants/templates'
require 'travis/client/definition'
require 'travis/client/resource/action'
require 'travis/client/resources'

module Travis
  module Client
    module Constants
      class Actions < Struct.new(:namespace, :resource, :name, :templates)
        include Helper::String

        def define
          action = const
          namespace.register("#{resource}_#{name}", action)
          namespace.register("#{name}_#{resource}", action)
          name = camelize("#{resource}_#{self.name}")
          namespace.const_set(name, action) unless namespace.const_defined?(name, false)
          action
        end

        def const
          const = Class.new(Resource::Action)
          const.definition = Definition::Action.new(resource, name, templates)
          const
        end

        def templates
          Templates.new(resource, super).define
        end
      end
    end
  end
end

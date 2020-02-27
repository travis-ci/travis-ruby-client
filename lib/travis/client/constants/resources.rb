require 'travis/client/helper'
require 'travis/client/constants/actions'
require 'travis/client/resource/action'
require 'travis/client/resource/collection'
require 'travis/client/resource/error'
require 'travis/client/resource/entity'
require 'travis/client/resources'
require 'travis/client/session'

module Travis
  module Client
    module Constants
      class Resources < Struct.new(:index)
        include Helper::String

        attr_reader :namespace

        def define
          define_namespace
          define_resources(:entity, index.resources)
          define_resources(:error, index.errors)
          namespace
        end

        private

          def define_namespace
            @namespace ||= Client::Resources.const_set index.hash, Module.new {
              include Registry
              extend Helper::String
            }
          end

          def define_resources(type, resources)
            resources.each do |name, resource|
              define_resource(type, name, resource)
            end
          end

          def define_resource(type, name, definition)
            const = Class.new(superclass_for(type, name, definition))
            define_attributes(const, definition[:attributes])
            define_actions(const, name, definition[:actions])
            namespace.const_set(camelize(name), const) unless namespace.const_defined?(camelize(name), false)
            namespace.register(name, const)
          end

          def define_attributes(const, attrs)
            Array(attrs).each do |name|
              const.send(:define_method, name) { self[name] }
              const.send(:define_method, "#{name}?") { !!send(name) }
            end
          end

          def define_actions(const, resource, actions)
            Hash(actions).each do |name, templates|
              action = Actions.new(namespace, resource, name, templates).define
              define_const_action(const, resource, name, action)
              define_session_actions(resource, name, action)
            end
          end

          def define_const_action(const, resource, name, action)
            const.send(:define_singleton_method, name) do |params = {}|
              action.new(Client.session, params).call
            end
          end

          def define_session_actions(resource, name, action)
            names = resource == name ? [name] : %W(#{resource}_#{name} #{name}_#{resource})
            names.each do |name|
              Session.send(:define_method, name) do |params = {}|
                action.new(self, params).call
              end
            end
          end

          def superclass_for(type, name, definition)
            if type == :error
              Resource::Error
            elsif definition[:attributes] == [name.to_s]
              Resource::Collection
            else
              Resource::Entity
            end
          end

          # def define_related_action(own_type, other_type, name, action)
          #   if name == 'find' or name.start_with? 'for_'
          #     add_action(own_type, other_type, action, instance_only: true)
          #   end
          #
          #   if name != "for_#{own_type}"
          #     add_action(own_type, "#{other_type}_#{name}", action, instance_only: true)
          #     add_action(own_type, "#{name}_#{other_type}", action, instance_only: true)
          #   end
          # end
      end
    end
  end
end

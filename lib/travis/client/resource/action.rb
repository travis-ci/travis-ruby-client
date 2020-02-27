# frozen_string_literal: true
require 'addressable/uri'
require 'addressable/template'
require 'travis/client/errors'
require 'travis/client/helper'
require 'travis/client/resource/template'

module Travis
  module Client
    module Resource
      class Action < Struct.new(:session, :params)
        include Errors, Helper::Hash

        singleton_class.send(:attr_accessor, :definition)

        %i(resource name).each do |key|
          define_method(key) { self.class.definition.send(key) }
        end

        def call
          method, url, payload = request
          invalid_params(params) unless method
          session.request(method, url, payload, opts)
        end

        def accepted_types
          templates.flat_map(&:accepted_types).uniq
        end

        private

          def request
            # params = { params[:@type] => params } if params.is_a?(Resource::Entity) and params[:@type]
            # params = params.to_h
            [template.method, template.uri, template.payload] if template
          end

          def template
            templates.detect { |template| template.accept? }
          end

          def templates
            self.class.definition.templates.map do |const|
              const.new(except(params, :pages, :page))
            end
          end

          def invalid_params(params)
            super(templates.map(&:possible_params), params.keys)
          end

          def opts
            @opts ||= only(params, :pages, :page)
          end

          # def instance_action?(prefix)
          #   prefix = "#{prefix}."
          #   templates.any? do |template|
          #     template.mandatory.any? { |key| key.start_with?(prefix) }
          #   end
          # end
      end
    end
  end
end

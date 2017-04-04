# frozen_string_literal: true
module Travis::Client
  class Error < StandardError
    @entity_factory  = Entity = Class.new(Travis::Client::Entity)
    @default_message = 'unknown error'

    def self.add_attribute(name)
      entity_factory.add_attribute(name)
      define_method(name) { entity.public_send(name) } unless method_defined? name
    end

    def self.default_message=(message)
      @default_message = message
    end

    def self.for_session(session)
      self
    end

    def self.default_message
      @default_message ||= superclass.default_message
    end

    def self.entity_factory
      @entity_factory ||= Class.new(superclass.entity_factory)
    end

    attr_reader :entity

    def initialize(session, message)
      @entity = self.class.entity_factory.new(session, nil)
      super(message)
    end

    def merge!(data)
      entity.merge!(data)
    end

    def to_h
      entity.to_h
    end

    def to_entity
      entity
    end
  end
end

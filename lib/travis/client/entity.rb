# frozen_string_literal: true
module Travis::Client
  class Entity
    def self.add_attribute(name)
      define_method(name) { self[name] } unless method_defined? name
      define_method("#{name}?") { !!public_send(name) } unless method_defined? "#{name}?"
    end

    def self.add_action(resource_type, name, action, instance_only: false)
      if name == action.name and !respond_to?(name, true) and !instance_only
        define_singleton_method(name) { |params = {}| action.call(session, params) }
      end

      if action.instance_action?(resource_type) and not method_defined? name
        define_method(name) { |params = {}| action.call(session, params.merge(resource_type => self)) }
      end
    end

    def self.add_related_action(own_type, other_type, name, action)
      if name == 'find' or name.start_with? 'for_'
        add_action(own_type, other_type, action, instance_only: true)
      end

      if name != "for_#{own_type}"
        add_action(own_type, "#{other_type}_#{name}", action, instance_only: true)
        add_action(own_type, "#{name}_#{other_type}", action, instance_only: true)
      end
    end

    def self.for_session(session)
      Class.new(self) { define_singleton_method(:session) { session } }
    end

    attr_reader :session

    def initialize(session, href)
      @session = session
      @href    = href
      @payload = {}
    end

    def inspect
      @href ? "#<%p:%p>" % [self.class, @href.path] : "#<%p>" % [self.class]
    end

    def to_h
      @payload.dup
    end

    def to_entity
      self
    end

    def [](key)
      key = key.to_s

      if @href and type = @payload['@type'] and not @payload.include? key
        href = @href.dup
        href.query_values = { 'include' => "#{type}.#{key}" }
        @session.request('GET', href)
        @payload.fetch(key) { @payload[key] = nil }
      end

      result = @payload[key]
      result = result.fetch if result.is_a? Link
      result
    end

    def merge!(data)
      @payload.merge! data
    end

    def permission?(key)
      Hash(self['@permissions'])[key.to_s]
    end
  end
end

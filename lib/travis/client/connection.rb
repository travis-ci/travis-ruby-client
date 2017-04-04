# frozen_string_literal: true
module Travis::Client
  class Connection
    Env                    = Struct.new(:request_method, :uri, :params, :response, :meta_data)
    DEFAULT_HEADERS        = {
      "Travis-API-Version" => "3",
      "Accept"             => "application/json",
      "User-Agent"         => "Travis/#{VERSION} Ruby/#{RUBY_VERSION}" }
    PREDEFINED             = {
      'home'               => { '@type' => 'resource', 'attributes' => ['config', 'errors', 'resources'] },
      'resource'           => { '@type' => 'resource', 'attributes' => ['actions', 'attributes', 'representations', 'permissions'] },
      'template'           => { '@type' => 'resource', 'attributes' => ['request_method', 'uri_template', 'accepted_params'] }}

    private_constant :DEFAULT_HEADERS, :PREDEFINED

    attr_reader :request_headers, :service_index, :resource_types, :error_types, :mixin, :actions, :http_factory, :access_token

    def initialize(endpoint: Travis.default_endpoint, request_headers: {}, access_token: nil, http_factory: HTTP)
      @request_headers, @mixin                = DEFAULT_HEADERS.merge(request_headers).freeze, Module.new
      @error_types, @resource_types, @actions = {}, {}, {}
      @before_callbacks, @after_callbacks     = [], []
      @session_factory, @http_factory         = Class.new(Session), http_factory
      @access_token                           = access_token
      @default_session                        = create_session

      yield self if block_given?

      load_resource(PREDEFINED, endpoint)
      @service_index = @default_session.request(:get, endpoint)
      load_resource(service_index.resources, endpoint)
      load_errors(service_index.errors)
      define_actions

      @session_factory.include(@mixin)
    end

    def create_session(**options)
      options[:access_token] ||= access_token
      @session_factory.new(self, **options)
    end

    def before_request(callback = Proc.new)
      @before_callbacks << callback
    end

    def after_request(callback = Proc.new)
      @after_callbacks << callback
    end

    def notify(method, uri, params)
      env = Env.new(method, uri, params, nil, {})
      @before_callbacks.each { |c| c.call(env) }
      env.response = yield
      @after_callbacks.each { |c| c.call(env) }
      env.response
    end

    def action(resource_type, action_name)
      actions.
        fetch(resource_type.to_s) { raise ArgumentError, 'unknown resource type' }.
        fetch(action_name.to_s)   { raise ArgumentError, 'unknown action'        }
    end

    private def add_action(base_href, type, name, templates)
      action              = Action.new(base_href, type, name)
      actions[type]     ||= {}
      actions[type][name] = action
      templates.each { |t| action.add_template(t.request_method, t.uri_template, t.accepted_params)}
    end

    private def load_resource(resources, base_href)
      resources.each do |type, definition|
        factory = resource_types.fetch(type) { resource_types[type] = Class.new(superclass_for(type, definition)) }
        Array(definition['attributes']).each { |attribute| factory.add_attribute(attribute) }
        Hash(definition['actions']).each { |key, value| add_action(base_href, type, key, Array(value)) }
      end
    end

    private def superclass_for(type, definition)
      return Error if type == 'error'
      definition['attributes'] == [type] ? Collection : Entity
    end

    private def load_errors(errors)
      errors.each do |type, definition|
        factory = error_types.fetch(type) {  error_types[type] = Class.new(resource_types.fetch('error')) }
        Array(definition['additional_attributes']).each { |attribute| factory.add_attribute(attribute) }
        factory.default_message = definition['default_message']
      end
    end

    private def define_actions
      actions.each do |resource_type, mapping|
        factory = resource_types[resource_type]
        mapping.each do |name, action|
          factory.add_action(resource_type, name, action)
          action.accepted_types.each { |t| resource_types[t].add_related_action(t, resource_type, name, action) if t != resource_type and resource_types.include? t }
          @mixin.module_eval { define_method("#{resource_type}_#{name}") { |params={}| action.call(session, params) }} unless @mixin.method_defined? "#{resource_type}_#{name}"
          @mixin.module_eval { define_method("#{name}_#{resource_type}") { |params={}| action.call(session, params) }} unless @mixin.method_defined? "#{name}_#{resource_type}"
        end
      end
    end
  end
end

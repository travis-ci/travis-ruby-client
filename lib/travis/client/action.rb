# frozen_string_literal: true
module Travis::Client
  class Action
    class Template < Struct.new(:method, :uri_template, :mandatory, :optional, :body_params)
      def map_params(params, prefix)
        params.map { |key, value| map_pair(key.to_s, value, prefix).to_h }.inject({}, &:merge)
      end

      def map_pair(key, value, prefix)
        return                                             if value.nil?
        return entity_params(key, value)                   if value.is_a? Entity
        return map_pair("#{prefix}.#{key}", value, prefix) if !params.include?(key) and params.include?("#{prefix}.#{key}")

        if value.is_a? Hash and !body_params.include? key
          return value.map { |k,v| map_pair("#{prefix}.#{k}", v, prefix).to_h }.inject(&:merge)
        end

        if mandatory.include? key or optional.include? key
          value = prepare_segment(value)
        else
          value = prepare_json(value)
        end

        { key => value }
      end

      def prepare_segment(value)
        case value
        when Array then value.map { |v| prepare_segment(v) }.join(',')
        else value.to_s
        end
      end

      def prepare_json(value)
        value
      end

      def entity_params(key, value)
        result = {}
        params.each do |param|
          next unless param =~ /^#{key}\.(.+)$/
          next unless value.respond_to? $1
          result[param] = value.public_send($1)
        end
        result[key] = value if result.empty?
        result
      end

      def uri(params)
        uri_template.expand(params)
      end

      def payload(params)
        params.reject { |k,_| mandatory.include? k or optional.include? k }
      end

      def params
        @params ||= mandatory + optional + body_params
      end

      def accept_everything?
        method != 'GET' and body_params.empty?
      end

      def possible_params(prefix)
        [mandatory, optional + body_params].
          map { |list| list.map { |p| p.sub(/^#{prefix}\./, '').inspect }.join(',') if list.any? }.
          compact.join(', optionally ')
      end
    end

    METHOD_ORDER = ['GET', 'PATCH', 'DELETE', 'PUT', 'POST']

    attr_reader :resource_type, :name, :templates

    def initialize(base_href, resource_type, name)
      @resource_type, @name = resource_type, name
      @base_href            = Addressable::URI.parse(base_href)
      @templates            = []
    end

    def call(session, params)
      method, url, payload = request_for(params)
      raise ArgumentError, "parameters don't match action, possible parameters: #{possible_params}, given: #{params.keys.map { |k| k.to_s.inspect }.join(', ')}" unless method
      session.request(method, url, payload)
    end

    def possible_params
      templates.map { |t| t.possible_params(resource_type) }.join('; or ')
    end

    def accepted_types
      templates.flat_map { |t| t.mandatory.map { |k| k.split('.', 2).first if k.include? '.' }.compact }.uniq
    end

    def instance_action?(prefix)
      prefix = "#{prefix}."
      templates.any? do |template|
        template.mandatory.any? { |key| key.start_with? prefix }
      end
    end

    def request_for(params)
      params = { params['@type'] => params } if params.is_a? Entity and params['@type']
      params = params.to_h

      templates.each do |template|
        mapped = template.map_params(params, resource_type)
        next unless template.mandatory.all? { |k| mapped.include? k }
        next unless template.accept_everything? or mapped.keys.all? { |k| template.params.include? k }
        return [template.method, template.uri(mapped), template.payload(mapped)]
      end
      false
    end

    def add_template(method, pattern, accepted_params = nil)
      uri_template = Addressable::Template.new(@base_href.join(pattern).to_s)
      template     = Template.new(method, uri_template, [], [], Array(accepted_params))
      pattern.scan(/\{(\W?)(?:([^\}]+))\}/) do |prefix, params|
        list   = prefix == '?' ? template.optional : template.mandatory
        list.concat(params.split(','))
      end
      templates << template
      templates.sort_by { |t| [METHOD_ORDER.index(t.method) || METHOD_ORDER.size, -t.mandatory.size, t.optional.size] }
      self
    end
  end
end

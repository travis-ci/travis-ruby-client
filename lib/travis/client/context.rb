# frozen_string_literal: true
module Travis::Client
  module Context
    WARNING = 'WARNING: It is not recommended to call %p.connect more than once (%s).'
    private_constant :WARNING

    attr_accessor :default_endpoint
    attr_reader   :session, :connection

    def connect(**options)
      @call_site ||= caller.first
      if connected? and not defined? @warned
        line = @call_site == caller.first ? @call_site : "#{@call_site} and #{caller.first}"
        $stderr.puts(WARNING % [self, line])
        @warned = true
      end

      @connection = new(**options)
      @session    = @connection.create_session
      @session.define_constants(self)
      @session
    end

    def new(**options)
      Connection.new(**options)
    end

    def connected?
      !session.nil?
    end

    def clear_cache
      return unless connected?
      session.response_cache.clear
    end

    def before_request(&block)
      connection.before_request(&block)
    end

    def after_request(&block)
      connection.after_request(&block)
    end

    def const_missing(const)
      super
    rescue NameError => error
      message = connected? ? error.message :  "#{error.message}, try running #{self.inspect}.connect"
      raise error, message, caller(2)
    end
  end
end

# frozen_string_literal: true

require 'travis/client/session'
require 'travis/client/version'

module Travis
  module Client
    extend self

    attr_accessor :default_endpoint
    attr_reader :session, :session

    self.default_endpoint = 'https://api.travis-ci.com'
    # self.default_endpoint = 'https://api.travis-ci.org'
    # self.default_endpoint = 'http://localhost:3000'

    def new(**options)
      Session.new(**options)
    end

    def init(**options)
      @session = new(**options)
      self.class.include(session.namespace)
      session
    end

    def initialized?
      !session.nil?
    end

    # def reset
    #   @initialized, @session = nil
    #   Resources.reset
    # end

    def clear_cache
      return unless connected?
      session.cache.clear
    end

    def before_request(&block)
      session.before_request(&block)
    end

    def after_request(&block)
      session.after_request(&block)
    end

    def const_missing(name)
      return session.namespace.const_get(name) if session && session.namespace.const_defined?(name)
      super
    rescue NameError => error
      message = initialized? ? error.message :  "#{error.message}, try running #{inspect}.init"
      raise error, message, caller(2)
    end
  end
end

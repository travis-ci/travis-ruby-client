# frozen_string_literal: true
require 'travis/client/errors'

module Travis
  module Client
    module Resource
      class Error < Client::Error
        attr_reader :entity

        # def initialize(session, message, data)
        #   super(message)
        # end

        # def merge!(data)
        #   entity.merge!(data)
        # end
        #
        # def to_h
        #   entity.to_h
        # end
        #
        # def to_entity
        #   entity
        # end
      end
    end
  end
end

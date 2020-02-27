module Travis
  module Client
    Error = Class.new(StandardError)
    InvalidParams = Class.new(Error)

    module Errors
      MSGS = {
        invalid_params: 'parameters do not match action, possible parameters: %s (given: %s)'
      }

      def invalid_params(possible, given)
        raise InvalidParams, MSGS[:invalid_params] % [possible.join('; or '), given.map(&:inspect).join(', ')]
      end
    end
  end
end

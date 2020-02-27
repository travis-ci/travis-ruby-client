require 'registry'
require 'travis/client/helper'

module Travis
  module Client
    module Resources
      def self.namespace(name)
        const_get(name) if const_defined?(name)
      end
    end
  end
end

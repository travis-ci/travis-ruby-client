require 'travis/api/entity/repository'
require 'travis/api/entity/build'

module Travis

  module API

     # Travis API element representation

    class Entity

      # @param [Hash{String=>String,Fixnum}] attributes
      def initialize(attributes = {})
        @attributes = attributes
      end

      # Any of the attributes elements previously set on the initialization
      # will be accessible via its analog method.
      #
      # Example:
      #    Entity.new({:something => 'Hey There!'}).something #=> 'Hey There!'
      def method_missing(method, *args, &block)
        return @attributes[method.to_s] if @attributes.has_key?(method.to_s)
        super
      end

      # Adds the attributes elements to the list of methods that
      # the Entity will respond to.
      def respond_to?(method, include_private=false)
        @attributes.has_key?(method.to_s) || super(method, include_private)
      end	

    protected 
     
      def attributes
        @attributes
      end
   
    end

  end

end


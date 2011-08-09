require 'travis/api/entity/repository'
require 'travis/api/entity/build'

module Travis

  module API

     # Travis API elements representation

    class Entity

      # The attributs will be only assigned here

      def initialize(attributes={})
        @attributes = attributes
      end

      # Any attributes element previously set on the initialization
      # will be accessible via its analog metod.
      #
      # entity.attribute_name == @attributes['attribute_name']

      def method_missing(method, *args, &block)
        return @attributes[method.to_s] if @attributes.has_key?(method.to_s)
        super
      end

      # Adding the attributes elements to the list of methods that
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


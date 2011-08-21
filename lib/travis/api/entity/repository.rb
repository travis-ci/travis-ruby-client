module Travis

  module API
    
    class Entity
      
      # Travis API Repository representation

      class Repository < Entity
        
        # Repository's name
        #
        # @return [String, NilClass]
        attr_reader :name

        # Repository owner's name
        #
        # @return [String, NilClass]
        attr_reader :owner

        # @param [Hash{String=>String,Fixnum}] attributes
        # @param [String, NilClass] name Repository's name
        # @param [String, NilClass] owner Repository owner's name 
        def initialize(attributes = {}, owner = nil, name = nil)
          @owner = owner || attributes['slug'] && attributes['slug'].split('/').first
          @name = name || attributes['slug'] && attributes['slug'].split('/').last
          super(attributes)
        end

        # Returns the hash representation of the Repository
        #
        # @return [Hash{String=>String,Fixnum}]
        def to_hash
          return attributes()
        end

        # Fetches and returns its builds.
        # Once the collection is fetched it will remain cached until {#reload!} is called.
        #
        # @return [Array<Build>]
        def builds
          @builds ||= Client::Repositories.owner(self.owner).name(self.name).builds!
        end

        # Fetches and returns its latest build.
        # Once the build is fetched it will remain cached until {#reload!# is called.
        #
        # @return [Build]
        def last_build
          @last_build ||= Client::Repositories.owner(self.owner).name(self.name).build!(self.last_build_id)
        end

        # Erases the cached results and updates the repository attributes.
        #
        # @return [Boolean]
        def reload!
          @builds = nil
          @last_build = nil
          @attributes = Client::Repositories.owner(self.owner).name(self.name).fetch!.attributes
          true
        end
       
        # Retrurns the repository id
        # We were forced to define this method since on ruby versions < 1.9.2
        # {Object#id} is preventing the {Repository#id} reflection.
        #
        # @return [Fixnum] Repository ID
        def id
          @attributes['id']
        end

      end

    end

  end

end


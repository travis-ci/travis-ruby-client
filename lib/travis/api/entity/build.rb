module Travis

  module API
    
    class Entity

      # Travis API Build representation 

      class Build < Entity
      
        # @param [Hash] attributes
        # @param [String, NilClass] repository_owner The repository owner's name
        # @param [String, NilClass] repository_name The repository's name
        def initialize(attributes = {}, repository_owner = nil, repository_name = nil)
          @repository_owner = repository_owner
          @repository_name = repository_name
          super(attributes)
        end

        # Fetches and returns the parent build based on the build {#partner_id}.
        # Returns nil if the current buils is actually a parent.
        # Once the parent is fetched it will remain cached until {#reload!} is called.
        #  
        # @return [Build, NilClass]
        def parent
          return nil if self.matrix
          @parent ||= Client::Repositories.owner(self.repository_owner).name(self.repository_name).build!(self.partner_id)
        end

        # Fetches and returns its repository based on the build {#repository_id}.
        # Once the repository is fetched it will remain cached until {#reload!} is called.
        #
        # @return [Repository]
        def repository
          @repository ||= self.repository!        
        end

        # Returns the collection of its children builds or nil if the current
        # build is actually a child.
        #
        # @return [Array<Build>, NilClass]
        def matrix
          return nil unless @attributes.has_key?('matrix')
          @matrix ||= @attributes['matrix'].map {|build_data| Build.new(build_date, self.repository_owner, self.repository_name)}     
        end

        # Erases the cached results and updates its attributes.
        #
        # @return [Boolean]
        def reload!
          @repository = nil
          @parent = nil
          @matrix = nil
          @attributes = Client::Repositories.owner(self.repository_owner).name(self.repository_name).build!(self.id).attributes
          true
        end

      private

        # Fetches its repository by name and owner. If any of them is 
        # not present it will try to fetch the repository based on the {#repository_id}.
        #
        # @return [Repository]
        def repository!
          if @repository_owner && @repository_name
            Client::Repositories.owner(@repository_owner).name(@repository_name).fetch! 
          else
            Client::Repositories.id(self.repository_id).fetch! 
          end
        end

        # Returns the repository owner's name.
        #
        # @return [String]
        def repository_owner
          @repository_owner ||= self.repository.owner
        end

        # Returns the repository's name.
        #
        # @return [String]
        def repository_name
          @repository_name ||= self.repository.name
        end

      end

    end

  end

end


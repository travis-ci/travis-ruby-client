module Travis

  module API
    
    class Entity

      # Travis API Build representation 

      class Build < Entity
      
        # @param [Hash{String=>String,Fixnum}] attributes
        # @param [String, NilClass] repository_owner The repository owner's name
        # @param [String, NilClass] repository_name The repository's name
        def initialize(attributes = {}, repository_owner = nil, repository_name = nil)
          @repository_owner = repository_owner
          @repository_name = repository_name
          super(attributes)
        end
        
        # Returns the hash representation of the Build
        #
        # @return [Hash{String=>String,Fixnum}]
        def to_hash
          return attributes()
        end

        # Fetches and returns the parent build based on the build {#partner_id}.
        # Returns nil if the current buils is actually a parent.
        # Once the parent is fetched it will remain cached until {#reload!} is called.
        #  
        # @return [Build, NilClass]
        def parent
          return nil if self.matrix
          @parent ||= Client::Repositories.owner(repository_owner()).name(repository_name()).build!(self.partner_id)
        end

        # Fetches and returns its repository based on the build {#repository_id}.
        # Once the repository is fetched it will remain cached until {#reload!} is called.
        #
        # @return [Repository]
        def repository
          @repository ||= repository!()
        end

        # Returns the collection of its children builds or nil if the current
        # build is actually a child.
        #
        # @return [Array<Build>, NilClass]
        def matrix
          return nil unless @attributes.has_key?('matrix')
          @matrix ||= @attributes['matrix'].map {|build_data| Build.new(build_data, repository_owner(), repository_name())}     
        end

        # Erases the cached results and updates its attributes.
        #
        # @return [Boolean]
        def reload!
          @repository = nil
          @parent = nil
          @matrix = nil
          @attributes = Client::Repositories.owner(repository_owner()).name(repository_name()).build!(self.id).attributes
          true
        end

        # Retrurns the build id
        # We were forced to define this method since on ruby versions < 1.9.2
        # {Object#id} is preventing the {Build#id} reflection.
        #
        # @return [Fixnum] Build ID
        def id
          @attributes['id']
        end

        # Returns its execution time
        # We were forced to define this method since started_at may be not
        # be present on the response, until the build starts its execution,
        # causing an exception.
        #
        # @return [String,NilClass]
        def started_at
          @attributes['started_at']
        end

        # Returns its end of execution time
        # We were forced to define this method since finished_at may be not
        # be present on the response, until the build starts its execution,
        # causing an exception.
        #
        # @return [String,NilClass]
        def finished_at
          @attributes['finished_at']
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


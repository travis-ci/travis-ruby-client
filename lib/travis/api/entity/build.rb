module Travis

  module API
    
    class Entity

      # Travis API Build representation 

      class Build < Entity
      
        # The following attributes will eb accessible as public methods:
        #
        #   :number, :commited_at, :commit, :finished_at, :config, :author_name, :log, :branch, :id, :parent_id, :started_at, :author_email, :status, :repository_id, :message, :compare_url
        
        def initialize(attributes={}, repository_owner=nil, repository_name=nil)
          @repository_owner = repository_owner
          @repository_name = repository_name
          super(attributes)
        end

        # Fetches and returns the parent Build based on the Build partner_id.
        # Returns nil if the current Buils is actually the parent.
        # Once the parent is fetched it will remain cached until relaod! is called.

        def parent
          return nil if self.matrix
          @parent ||= Client::Repositories.owner(self.repository_owner).name(self.repository_name).build!(self.partner_id)
        end

        # Fetches and returns its Repository based on the Build repository_id.
        # Once the Repository is fetched it will remain cached until relaod! is called.

        def repository
          @repository ||= self.repository!        
        end

        # Returns the collection of its children build or nil if the current
        # Build is actually a child.

        def matrix
          return nil unless @attributes.has_key?('matrix')
          @matrix ||= @attributes['matrix'].map {|build_data| Build.new(build_date, self.repository_owner, self.repository_name)}     
        end

        # Erases the cached results and updates its attributes.

        def reload!
          @repository = nil
          @parent = nil
          @matrix = nil
          @attributes = Client::Repositories.owner(self.repository_owner).name(self.repository_name).build!(self.id).attributes
        end

      private

        # Fetches its repository by name and owner. If any of them is 
        # not present it will try to fetch the Repository based on the repository_id.

        def repository!
          if @repository_owner && @repository_name
            Client::Repositories.owner(@repository_owner).name(@repository_name).fetch! 
          else
            Client::Repositories.id(self.repository_id).fetch! 
          end
        end

        # Returns the repository owner.

        def repository_owner
          @repository_owner ||= self.repository.owner
        end

        # Returns the repository name.

        def repository_name
          @repository_name ||= self.repository.name
        end

      end

    end

  end

end


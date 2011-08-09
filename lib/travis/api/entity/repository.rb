module Travis

  module API
    
    class Entity
      
      # Travis API Repository representation

      class Repository < Entity
        
        # The following attributes will eb accessible as public methods:
        #
        #   :slug, :id, :status, :last_build_id, :last_build_status, :last_build_number, :last_build_finished_at

        attr_reader :name, :owner

        def initialize(attributes={}, owner=nil, name=nil)
          @owner = owner || attributes["slug"] && attributes["slug"].split('/').first
          @name = name || attributes["slug"] && attributes["slug"].split('/').last
          super(attributes)
        end

        # Fetches and returns its builds.
        # Once the collection is fetched it will remain cached until reload! is called.

        def builds
          @builds ||= Client::Repositories.owner(self.owner).name(self.name).builds!
        end

        # Fetches and returns the latest Build.
        # Once the Build is fetched it will remain cached until reload! is called.

        def last_build
          @last_build ||= Client::Repositories.owner(self.owner).name(self.name).build!(self.last_build_id)
        end

        # Erases the cached results and updates the Repository attributes.

        def reload!
          @builds = nil
          @last_build = nil
          @attributes = Client::Repositories.owner(self.owner).name(self.name).fetch!.attributes
        end

      end

    end

  end

end


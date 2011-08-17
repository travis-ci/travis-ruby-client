module Travis

  module API
  
    class Client
      
      # Travis API Client for Repositories 

      class Repositories < Client

        # Returns the cached list of repositories or fetches the 
        # recent list if there's nothing already cached.
        # 
        # @return [Array<Entity::Repository>] 
        def all
          #Having some issues with the cached repositories
          #@@repositories || self.all!
          self.all!
        end    

        # Fetches and return the list of recent repositories.
        # It also updates the repositorires cache.
        #
        # @return [Array<Entity::Repository>]
        def all!
          @@repositories = results_for(REPOSITORIES_PATH).map {|repository_data| Entity::Repository.new(repository_data)}
        end

        # Returns a repository from the cache or fetches it 
        # based on the previously set options (name and owner or slug or id).
        #
        # @return [Entity::Repository]
        def fetch
          #Having some issues with the cached repositories
          #fetch_from_cache() || self.fetch!
          self.fetch!
        end

        # Fetches and return a repository based on the previously 
        # set options (name and owner or slug or id).
        # It also adds this repository to the repositories cache.
        #
        # @return [Entity::Repository]
        def fetch!
          repository = @options[:id] ? fetch_by_id!() : fetch_by_owner_and_name!() 
          repositories_cache() << repository
          repository
        end

        # Returns the cached list of builds or fetches the 
        # recent list if there's nothing already cached.
        #
        # @return [Array<Entity::Build>]
        def builds
          #Having some issues with the cahced builds
          #@@builds || self.builds!
          self.builds!
        end

        # Fetches and return the list of recent builds.
        # It also updates the builds cache.
        #
        # @return [Array<Entity::Build>]
        def builds!
          @@builds = results_for(REPOSITORY_BUILDS_PATH).map {|build_data| Entity::Build.new(build_data, @options[:owner], @options[:name])}
        end
     
        # Returns a build from the cache or fetches it 
        # based on the given build id and the previously set 
        # options (name and owner or slug or id).
        #
        # @return [Entity::Build]
        def build(build_id)
          #Having some issues with the cached builds
          #build_from_cache(build_id) || self.build!(build_id) 
          self.build!(build_id)
        end

        # Fetches and return a build based on the given
        # build id and the previously set options (name and owner or
        # slug or id).
        # It also adds this build to the builds cache.
        #
        # @return [Entity::Build]
        def build!(build_id)
          @options[:build_id] = build_id.to_s
          builds_cache().delete_if {|b| b.id == @options[:build_id]}
          build = Entity::Build.new(results_for(REPOSITORY_BUILD_PATH), @options[:owner], @options[:name])
          builds_cache() << build
          build
        end

        # Sets the target repository id and return the host client instance.
        # @param [Fixnum, String] id The target repository id.
        # @return [Client::Repositories] The host client instance.
        def id(id)
          @options[:id] = id
          self
        end
        
        # Sets the target repository owner and return the host client instance.
        # @param [String] owner The target repository owner.
        # @return [Client::Repositories] The host client instance.
        def owner(owner)
          @options[:owner] = owner
          self
        end    

        # Sets the target repository name and return the host client instance.
        # @param [String] name The target repository name.
        # @return [Client::Repositories] The host client instance.
        def name(name)
          @options[:name] = name
          self
        end

        # Sets the target repository slug and return the host client instance.
        # @param [String] slug The target repository slug.
        # @return [Client::Repositories] The host client instance.  
        def slug(slug)
          @options[:owner], @options[:name] = slug.split('/')
          self
        end

        # Twick to accept `self.name(param)` as class method. It won't
        # raise the NoMethodError but an ArgumentError so we can not
        # apply reflection.
        # Sice we are polite programmers the class still respond to the
        # `self.name()` class method
        #
        # Creates an instance of the client, sets the target repository
# name and returns the host client instance.
        #
        # @param [String] name The target repository name.

        # @return [Client::Repositories] The host client instance.
        def self.name(name = nil)
          return super unless name
          self.new.name(name)
        end

      private

        # API Path template for a repository
        REPOSITORY_PATH        = '/:owner/:name.:format'

        # API Path template for the repository listing
        REPOSITORIES_PATH      = '/repositories.:format'

        # API Path template for a repository build
        REPOSITORY_BUILD_PATH  = '/:owner/:name/builds/:build_id.:format'
       
        # API Path template for the repository build listing
        REPOSITORY_BUILDS_PATH = '/:owner/:name/builds.:format'

        # Cached repositories
        # @return [Array<Entity::Repository>, NilClass] 
        @@repositories = nil

        # Cached builds
        # @return [Array<Entity::Build>, NilClass]
        @@builds = nil

        # Returns the cached collection of repositories
        # or an empty array if it was not initialized yet.
        #
        # @return [Array<Entity::Repository>, NilClass]
        def repositories_cache
          @@repositories || []
        end

        # Returns the cached collection of builds
        # or an empty array if it was not initialized yet.
        #
        # @return [Array<Entity::Build>, NilClass]
        def builds_cache
          @@builds || []
        end

        # Fetches and returns a repository based on the
        # owner and name option values.
        #
        # @return [Entity::Repository]
        def fetch_by_owner_and_name!
          repositories_cache().delete_if {|r| r.owner == @options[:owner] && r.name == @options[:name]}
          repository_data = results_for(REPOSITORY_PATH)
          return repository_data && Entity::Repository.new(repository_data, @options[:owner], @options[:name])
        end

        # Right now there's no way to get a repository directly by id.
        #
        # Iterates over the recent repositories trying to find the target repo by id.
        #
        # It will fail most of the times since the recent repositories is a really small list.
        # Looking forward for an API call to get repos by id or at list one to get all the repos and 
        # not just the recent ones.
        #
        # Fetches and returns a repository based the id option value.
        # If the Repository can not be found an exception will be rised.
        #
        # @return [Entity::Repository]
        def fetch_by_id!
          repositories_cache().delete_if {|r| r.id == @options[:id]}
          return self.all!.find {|r| r.id == @options[:id]} || raise("Repository not found: id => #{@options[:id]}")
        end

        # Looks into the cache for a repository, based on the previously set
        # id or name and owner, returning the repository or nil if it's not present.
        #
        # @return [Entity::Repository, NilClass]
        def fetch_from_cache
          if @options[:id]
            repositories_cache().find {|repository| repository.id == @options[:id].to_i}
          else
            repositories_cache().find {|repository| repository.owner == @options[:owner] && repository.name == @options[:name]}
          end
        end

        # Looks into the cache for a build, based on the given build id,
        # returning the build or nil if it's not present.
        #
        # @return [Entity::Build, NilClass]
        def build_from_cache(build_id)
          builds_cache().find {|build| build.id == build_id.to_s} 
        end

      end

    end

  end

end


module Travis

  module API
  
    class Client
      
      # Travis API Client for Repositories

      class Repositories < Client
        #Cache Variables
        @@repositories       = nil
        @@builds             = nil

        # Returns the cached list of Repository instances or fetches the 
        # recent list if there's nothing already cached.

        def all
          @@repositories || self.all!
        end    

        # Fetches and return the list of recent repositories.
        # It also updates the repositorires cache.

        def all!
          @@repositories = results_for(REPOSITORIES_PATH).map {|repository_data| Entity::Repository.new(repository_data)}
        end

        # Returns a Repository instance from the cache or fetches it 
        # based on the previously set options (name and owner, slug or id).
          
        def fetch
          fetch_from_cache() || self.fetch!
        end

        # Fetches and return a Repository instance based on the previously 
        # set options (name and owner, slug or id).
        # It also adds this Repository to the repositories cache.

        def fetch!
          repository = @options[:id] ? fetch_by_id!() : fetch_by_owner_and_name!() 
          repositories_cache() << repository
          repository
        end

        # Returns the cached list of Build instances or fetches the 
        # recent list if there's nothing already cached.

        def builds
          @@builds || self.builds!
        end

        # Fetches and return the list of recent builds.
        # It also updates the builds cache.

        def builds!
          @@builds = results_for(REPOSITORY_BUILDS_PATH).map {|build_data| Entity::Build.new(build_data, @options[:owner], @options[:name])}
        end
     
        # Returns a Build instance from the cache or fetches it 
        # based on the given build id and the previously set 
        # options (name and owner, slug or id).

        def build(build_id)
          build_from_cache(build_id) || self.build!(build_id) 
        end

        # Fetches and return a Build instance based on the given
        # build id and the previously set options (name and owner, 
        # slug or id).
        # It also adds this Build to the builds cache.

        def build!(build_id)
          @options[:build_id] = build_id.to_s
          builds_cache().delete_if {|b| b.id == @options[:build_id]}
          build = Entity::Build.new(results_for(REPOSITORY_BUILD_PATH), @options[:owner], @options[:name])
          builds_cache() << build
          build
        end

        # Sets the options id and returns the Client instance.

        def id(id)
          @options[:id] = id
          self
        end
        
        # Sets the options owner and return the Client instance.

        def owner(owner)
          @options[:owner] = owner
          self
        end    

        # Sets the options name and returns the Client instance.

        def name(name)
          @options[:name] = name
          self
        end

        # Sets the options slug and return the Client instance.

        def slug(slug)
          @options[:owner], @options[:name] = slug.split('/')
          self
        end

        # Twick to accept name(param) as class method since it won't
        # raise the NoMethodError but an ArgumentError.
        # Sice we are polite programmers the class still respond to the
        # name() class method

        def self.name(name=nil)
          return super unless name
          self.new.name(name)
        end

      private

        # API Path templates
        # TODO: Move them toa configuration file?

        REPOSITORY_PATH        = '/:owner/:name.:format'
        REPOSITORIES_PATH      = '/repositories.:format'
        REPOSITORY_BUILD_PATH  = '/:owner/:name/builds/:build_id.:format'
        REPOSITORY_BUILDS_PATH = '/:owner/:name/builds.:format'

        # Returns the cached collection of Repository instances
        # or an empty array if it was not initialized yet.

        def repositories_cache
          @@repositories || []
        end

        # Returns the cached collection of Build instances
        # or an empty array if it was not initialized yet.

        def builds_cache
          @@builds || []
        end

        # Fetches and returns a Repository instace guessing that
        # the owner and name options are already set

        def fetch_by_owner_and_name!
          repositories_cache().delete_if {|r| r.owner == @options[:owner] && r.name == @options[:name]}
          return Entity::Repository.new(results_for(REPOSITORY_PATH), @options[:owner], @options[:name])
        end

        # Right now there's no way to get a repository directly by id.
        #
        # Iterates over the recent repositories trying to find the target repo by id.
        #
        # It will fail most of the times since the recent repositories is a really small list.
        # Looking forward for an API call to get repos by id or at list one to get all the repos and 
        # not just the recent ones.

        # Fetches and returns a Repository instance guessing that
        # the id option was already set
        # If the Repository can not be found an exception will be rised
      
        def fetch_by_id!
          repositories_cache().delete_if {|r| r.id == @options[:id]}
          return self.all!.find {|r| r.id == @options[:id]} || raise("Repository not found: id => #{@options[:id]}")
        end

        # Looks into the cache for a Repository instance based on the previously set
        # id or name and owner returning the Repository or nil if it's not present.

        def fetch_from_cache
          if @options[:id]
            repositories_cache().find {|repository| repository.id == @options[:id].to_i}
          else
            repositories_cache().find {|repository| repository.owner == @options[:owner] && repository.name == @options[:name]}
          end
        end

        # Looks into the cache for a Build instance based on the given build id
        # returning the Build or nil if it's not present.

        def build_from_cache(build_id)
          builds_cache().find {|build| build.id == build_id.to_s} 
        end

      end

    end

  end

end


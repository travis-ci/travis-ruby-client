module Travis

  class Client

    # Travis Command Line Client for Repositories
    class Repositories < Client

      # Display a table with the list of the recent processed repositories
      def recent
        $stdout.print("Fetching recent repositories ...\n\n")
        $stdout.print(repositories_table_for(API::Client::Repositories.all!))
        $stdout.print("\n")
      end

      # Display detailed information of the requested repository
      def fetch
        $stdout.print("Fetching repository #{options().owner}/#{options().name} ...\n\n")
        if repository = API::Client::Repositories.owner(options().owner).name(options().name).fetch!
          $stdout.print(repository_view_for(repository))
        else
          $stdout.print("\033\[33mCould not find the #{options().owner}/#{options().name} repository.\033\[0m")
        end
        $stdout.print("\n")
      end

      # Display a table with the list of the requested repositories
      def fetch_group
        $stdout.print("Fetching repositories #{options().slugs.join(', ')} ...\n")
        repositories = options().slugs.map {|slug| API::Client::Repositories.slug(slug).fetch! || $stdout.print("\033\[33mCould not find the #{slug} repository\033\[0m\n")}.compact
        $stdout.print("\n")
        $stdout.print(repositories_table_for(repositories))
        $stdout.print("\n")
      end

      # Disaply a table with the list of recent proccessed repository builds
      def builds
        $stdout.print("Fetching #{options().owner}/#{options().name} builds ...\n\n")
        if builds = API::Client::Repositories.owner(options().owner).name(options().name).builds!
          $stdout.print(builds_table_for(builds))
        else
          $stdout.print("\033\[33mCould not find the #{options().owner}/#{options().name} repository.\033\[0m")
        end
        $stdout.print("\n")
      end

      # Display detailed information of the requested repository build
      def build
        $stdout.print("Fetching #{options().owner}/#{options().name} repository #{options().build_id} ...\n\n")
        if build = API::Client::Repositories.owner(options().owner).name(options().name).build!(options().build_id)
          $stdout.print(build_view_for(build))
        else
          $stdout.print("\033\[33mCould not find the #{options().owner}/#{options().name} build with ID = #{oprions().build_id}.\033\[0m")
        end
        $stdout.print("\n")
      end

    private
 
      # Labels for the repository tables
      # This also limits the information to be displayed. 
      #
      # @return [Array<String>] 
      REPOSITORY_FIELDS = ['ID', 'Slug', 'Status', 'Started At', 'Finished At', 'Build ID', 'Build Number']

      # Maps the repository attribute names with the table labels
      #
      # @return [Hash]
      REPOSITORY_FIELD_NAMES = {
        'id' => 'ID',
        'slug' => 'Slug',
        'last_build_status' => 'Status',
        'last_build_started_at' => 'Started At',
        'last_build_finished_at' => 'Finished At',
        'last_build_id' => 'Build ID',
        'last_build_number' => 'Build Number'
      }

      # Maps the status code from the API to its human translation.
      # It's meant to add colors too but the Hirb library is not handling
      # them properly.
      #
      # @return [Hash]
      BUILD_STATUS = {
        # Hirb is not handling special characters properly :S Will try to add colors later
        nil => 'Running', #"\033\[33mRunning\033\[0m",
        0   => 'Passing', #"\033\[32mPassing\033\[0m",
        1   => 'Failing'  #"\033\[31mFailing\033\[0m"
      }
      
      # Labels for the repository tables.
      # This also limits the information to be displayed. 
      #
      # @return [Array<String>] 
      BUILD_FIELDS = ['ID', 'Branch', 'Status', 'Started At', 'Finished At', 'Author', 'Commit', 'Repo ID']
      
      # Maps the build attribute names with the table labels
      #
      # @return [Hash]
      BUILD_FIELD_NAMES = {
        'id' => 'ID',
        'branch' => 'Branch',
        'status' => 'Status',
        'started_at' => 'Started At',
        'finished_at' => 'Finished At',
        'author_name' => 'Author',
        'commit' => 'Commit',
        'message' => 'Message',
        'compare_url' => 'Compare Url',
        'repository_id' => 'Repo ID',
        'number' => 'Numbre'
      }

      # Organize the present options and sets some defaults
      def handle_options
        set_default_options()
        super
      end

      # Sets the default options
      def set_default_options
        options().target = :recent
      end

      # Sets up the custom sections of the help message
      def setup_help(opts)
        opts.separator ''
        opts.separator <<-USAGE
Usage:
   travis repositories [--recent]
   travis repostiories --slugs={repository_slug}[,{repository_slug}[,...]]
   travis repositories --name={repository_name} --owner={owner_name}
   travis repostiories --slug={repository_slug}
   travis repositories --builds
   travis repositories --name={repository_name} --owner={owner_name} --build_id={build_id}
   travis repositories --slug={repository_slug} --build_id={build_id}
        USAGE

        yield(opts)
      end
      
      # Declares the list of available options that can be used.
      #
      # @return [Arrar<Array<String, Proc>>]
      def client_options
        super + [
          ['--recent', 'lists the recent processed repositories.',
            Proc.new {
              options().target = :recent
            }
          ],
          ['--builds', '-B', 'lists the recent builds for a repository.',
            Proc.new { 
              options().target = :builds
            }
          ],
          ['--owner=', '-o', 'sets the target repository owner\'s name.',
            Proc.new { |value|
              options().target = :fetch
              options().owner = value
            }
          ], 
          ['--name=', '-n', 'sets the target repository name.',
            Proc.new { |value|
              options().target = :fetch
              options().name = value
            }
          ], 
          ['--slug=', '-s', 'sets the target repositorys slug.',
            Proc.new { |value|
              options().target = :fetch
              owner, name = value.split('/')
              options().owner = owner
              options().name = name
            }
          ],
          ['--slugs=', '-S', 'sets the target repositories slugs (comma separated).',
            Proc.new { |value|
              options().target = :fetch_group
              options().slugs = value.split(',')
            }
          ],
          ['--build_id=', '-b', 'sets the target repository build id.',
            Proc.new { |value|
              options().target = :build
              options().build_id = value
            }
          ]
        ]
      end

      # Returns the formatted view of a repository
      #
      # @return [String]
      def repository_view_for(repository)
        #TODO: Create a more useful view. Using the listing table right now
        Hirb::Helpers::Table.render(
          [repository.to_hash], 
          {
            :description => false,
            :fields => REPOSITORY_FIELDS, 
            :change_fields => REPOSITORY_FIELD_NAMES,
            :filters => {
              'Status' => lambda { |status|
                BUILD_STATUS[status]  
              },
              'Started At' => lambda { |started_at|
                started_at ? DateTime.parse(started_at).strftime('%D %T') : '-----------------'
              },
              'Finished At' => lambda { |finished_at|
                finished_at ? DateTime.parse(finished_at).strftime('%D %T') : '-----------------'
              }
            }
          }
        )
      end

      # Returns the formatted table of repositories
      #
      # @return [String]
      def repositories_table_for(repositories)
        Hirb::Helpers::Table.render(
          repositories.map{|repo| repo.to_hash}, 
          {
            :description => false,
            :fields => REPOSITORY_FIELDS, 
            :change_fields => REPOSITORY_FIELD_NAMES,
            :filters => {
              'Status' => lambda { |status|
                BUILD_STATUS[status]  
              },
              'Started At' => lambda { |started_at|
                started_at ? DateTime.parse(started_at).strftime('%D %T') : '-----------------'
              },
              'Finished At' => lambda { |finished_at|
                finished_at ? DateTime.parse(finished_at).strftime('%D %T') : '-----------------'
              }
            }
          }
        )
      end
      
      # Returns the formatted table of builds
      #
      # @return [String]
      def builds_table_for(builds)
        Hirb::Helpers::Table.render(
          builds.map{|build| build.to_hash}, 
          {
            :description => false,
            :fields => BUILD_FIELDS, 
            :change_fields => BUILD_FIELD_NAMES,
            :max_fields => {
              'Commit' => 10
             },
            :filters => {
              'Status' => lambda { |status|
                BUILD_STATUS[status]  
              },
              'Started At' => lambda { |started_at|
                started_at ? DateTime.parse(started_at).strftime('%D %T') : '-----------------'
              },
              'Finished At' => lambda { |finished_at|
                finished_at ? DateTime.parse(finished_at).strftime('%D %T') : '-----------------'
              }
            }
          }
        )
      end
      
      # Returns the formatted view of a build
      #
      # @return [String]
      def build_view_for(build)
        #TODO: Create a more useful view. Using the listing table right now
        Hirb::Helpers::Table.render(
          [build.to_hash], 
          {
            :description => false,
            :fields => BUILD_FIELDS, 
            :change_fields => BUILD_FIELD_NAMES,
            :max_fields => {
              'Commit' => 10
             },
            :filters => {
              'Status' => lambda { |status|
                BUILD_STATUS[status]  
              },
              'Started At' => lambda { |started_at|
                started_at ? DateTime.parse(started_at).strftime('%D %T') : '-----------------'
              },
              'Finished At' => lambda { |finished_at|
                finished_at ? DateTime.parse(finished_at).strftime('%D %T') : '-----------------'
              }
            }
          }
        )
      end

    end

  end
  
end


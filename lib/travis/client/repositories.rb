module Travis

  class Client
  
    class Repositories < Client

      def recent
        $stdout.print("Fetching recent repositories ...\n\n")
        $stdout.print(repositories_table_for(API::Client::Repositories.all!))
        $stdout.print("\n")
      end

      def fetch
        $stdout.print("Fetching repository #{options().owner}/#{options().name} ...\n\n")
        $stdout.print(repository_view_for(API::Client::Repositories.owner(options().owner).name(options().name).fetch!))
        $stdout.print("\n")
      end

    private
 
      REPOSITORY_FIELDS = %w{ID Slug Status Started\ At Finished\ At Build\ ID Build\ Number}

      REPOSITORY_FIELD_NAMES = {
        'id' => 'ID',
        'slug' => 'Slug',
        'last_build_status' => 'Status',
        'last_build_started_at' => 'Started At',
        'last_build_finished_at' => 'Finished At',
        'last_build_id' => 'Build ID',
        'last_build_number' => 'Build Number'
      }

      REPOSITORY_STATUS = {
        # Hirb is not handling special characters properly :S Will try to add colors later
        nil => 'Running', #"\033\[33mRunning\033\[0m",
        0   => 'Passing', #"\033\[32mPassing\033\[0m",
        1   => 'Failing'  #"\033\[31mFailing\033\[0m"
      }

      def handle_options
        set_default_options()
        super
      end

      def set_default_options
        options().target = :recent
      end
      
      def client_options
        super + [
          ['--recent', 'List just the recent processed repositories [DEFAULT]',
            Proc.new {
              options().target = :recent
            }
          ],
          ['--owner=', '-o', 'Sets the Target Repository Owner\'s Name',
            Proc.new { |value|
              options().target = :fetch
              options().owner = value
            }
          ], 
          ['--name=', '-n', 'Sets the Target Repository\'s Name',
            Proc.new { |value|
              options().target = :fetch
              options().name = value
            }
          ], 
          ['--slug=', '-s', 'Sets the Target Repository\'s Slug',
            Proc.new { |value|
              options().target = :fetch
              owner, name = value.split('/')
              options().owner = owner
              options().name = name
            }
          ] 
        ]
      end

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
                REPOSITORY_STATUS[status]  
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

      def repositories_table_for(repositories)
        Hirb::Helpers::Table.render(
          repositories.map{|repo| repo.to_hash}, 
          {
            :description => false,
            :fields => REPOSITORY_FIELDS, 
            :change_fields => REPOSITORY_FIELD_NAMES,
            :filters => {
              'Status' => lambda { |status|
                REPOSITORY_STATUS[status]  
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
    

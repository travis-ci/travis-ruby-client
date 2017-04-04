# @!parse
#    class Travis::Home < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def config
#        # This is a placeholder.
#      end
#  
#      def errors
#        # This is a placeholder.
#      end
#  
#      def resources
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #config returns a truthy value (anything but `nil` or `false`).
#      def config?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #errors returns a truthy value (anything but `nil` or `false`).
#      def errors?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #resources returns a truthy value (anything but `nil` or `false`).
#      def resources?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Resource < Travis::Client::Entity
#      def attributes
#        # This is a placeholder.
#      end
#  
#      def permissions
#        # This is a placeholder.
#      end
#  
#      def actions
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #actions returns a truthy value (anything but `nil` or `false`).
#      def actions?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #attributes returns a truthy value (anything but `nil` or `false`).
#      def attributes?
#        # This is a placeholder.
#      end
#  
#      def representations
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #representations returns a truthy value (anything but `nil` or `false`).
#      def representations?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #permissions returns a truthy value (anything but `nil` or `false`).
#      def permissions?
#        # This is a placeholder.
#      end
#  
#      def access_rights
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #access_rights returns a truthy value (anything but `nil` or `false`).
#      def access_rights?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Template < Travis::Client::Entity
#      def request_method
#        # This is a placeholder.
#      end
#  
#      def uri_template
#        # This is a placeholder.
#      end
#  
#      def accepted_params
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #request_method returns a truthy value (anything but `nil` or `false`).
#      def request_method?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #uri_template returns a truthy value (anything but `nil` or `false`).
#      def uri_template?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #accepted_params returns a truthy value (anything but `nil` or `false`).
#      def accepted_params?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Account < Travis::Client::Entity
#    end
#  
#    class Travis::Active < Travis::Client::Entity
#      def self.for_owner(params = {})
#        # This is a placeholder.
#      end
#  
#      # The active builds.
#      def builds
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #builds returns a truthy value (anything but `nil` or `false`).
#      def builds?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::BetaFeature < Travis::Client::Entity
#      def self.delete(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.update(params = {})
#        # This is a placeholder.
#      end
#  
#      # The name of the feature.
#      def name
#        # This is a placeholder.
#      end
#  
#      def delete(params = {})
#        # This is a placeholder.
#      end
#  
#      def update(params = {})
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #enabled returns a truthy value (anything but `nil` or `false`).
#      def enabled?
#        # This is a placeholder.
#      end
#  
#      # Longer description of the feature.
#      def description
#        # This is a placeholder.
#      end
#  
#      # Value uniquely identifying the beta feature.
#      def id
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #name returns a truthy value (anything but `nil` or `false`).
#      def name?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #description returns a truthy value (anything but `nil` or `false`).
#      def description?
#        # This is a placeholder.
#      end
#  
#      # Indicates if the user has this feature turned on.
#      def enabled
#        # This is a placeholder.
#      end
#  
#      # Url for users to leave Travis CI feedback on this feature.
#      def feedback_url
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #feedback_url returns a truthy value (anything but `nil` or `false`).
#      def feedback_url?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::BetaFeatures < Travis::Client::Collection
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::Branch < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      # Name of the git branch.
#      def name
#        # This is a placeholder.
#      end
#  
#      def find(params = {})
#        # This is a placeholder.
#      end
#  
#      # GitHub user or organization the branch belongs to.
#      def repository
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #name returns a truthy value (anything but `nil` or `false`).
#      def name?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #repository returns a truthy value (anything but `nil` or `false`).
#      def repository?
#        # This is a placeholder.
#      end
#  
#      # Whether or not this is the resposiotry's default branch.
#      def default_branch
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #default_branch returns a truthy value (anything but `nil` or `false`).
#      def default_branch?
#        # This is a placeholder.
#      end
#  
#      # Whether or not the branch still exists on GitHub.
#      def exists_on_github
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #exists_on_github returns a truthy value (anything but `nil` or `false`).
#      def exists_on_github?
#        # This is a placeholder.
#      end
#  
#      # Last build on the branch.
#      def last_build
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #last_build returns a truthy value (anything but `nil` or `false`).
#      def last_build?
#        # This is a placeholder.
#      end
#  
#      def cron(params = {})
#        # This is a placeholder.
#      end
#  
#      def cron_create(params = {})
#        # This is a placeholder.
#      end
#  
#      def create_cron(params = {})
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Branches < Travis::Client::Collection
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::Broadcast < Travis::Client::Entity
#      # Message to display to the user.
#      def message
#        # This is a placeholder.
#      end
#  
#      # Whether or not the brodacast should still be displayed.
#      def active
#        # This is a placeholder.
#      end
#  
#      # Value uniquely identifying the broadcast.
#      def id
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #active returns a truthy value (anything but `nil` or `false`).
#      def active?
#        # This is a placeholder.
#      end
#  
#      # When the broadcast was created.
#      def created_at
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #message returns a truthy value (anything but `nil` or `false`).
#      def message?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #created_at returns a truthy value (anything but `nil` or `false`).
#      def created_at?
#        # This is a placeholder.
#      end
#  
#      # Broadcast category (used for icon and color)
#      def category
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #category returns a truthy value (anything but `nil` or `false`).
#      def category?
#        # This is a placeholder.
#      end
#  
#      # Either a user, organization or repository, or null for global.
#      def recipient
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #recipient returns a truthy value (anything but `nil` or `false`).
#      def recipient?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Broadcasts < Travis::Client::Collection
#      def self.for_current_user(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::Build < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.cancel(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.restart(params = {})
#        # This is a placeholder.
#      end
#  
#      def find(params = {})
#        # This is a placeholder.
#      end
#  
#      # Current state of the build.
#      def state
#        # This is a placeholder.
#      end
#  
#      # Value uniquely identifying the build.
#      def id
#        # This is a placeholder.
#      end
#  
#      # Incremental number for a repository's builds.
#      def number
#        # This is a placeholder.
#      end
#  
#      # GitHub user or organization the build belongs to.
#      def repository
#        # This is a placeholder.
#      end
#  
#      # The branch the build is associated with.
#      def branch
#        # This is a placeholder.
#      end
#  
#      # When the build started.
#      def started_at
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #repository returns a truthy value (anything but `nil` or `false`).
#      def repository?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #number returns a truthy value (anything but `nil` or `false`).
#      def number?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #state returns a truthy value (anything but `nil` or `false`).
#      def state?
#        # This is a placeholder.
#      end
#  
#      # Wall clock time in seconds.
#      def duration
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #duration returns a truthy value (anything but `nil` or `false`).
#      def duration?
#        # This is a placeholder.
#      end
#  
#      # Event that triggered the build.
#      def event_type
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #event_type returns a truthy value (anything but `nil` or `false`).
#      def event_type?
#        # This is a placeholder.
#      end
#  
#      # State of the previous build (useful to see if state changed)
#      def previous_state
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #previous_state returns a truthy value (anything but `nil` or `false`).
#      def previous_state?
#        # This is a placeholder.
#      end
#  
#      def pull_request_title
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #pull_request_title returns a truthy value (anything but `nil` or `false`).
#      def pull_request_title?
#        # This is a placeholder.
#      end
#  
#      def pull_request_number
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #pull_request_number returns a truthy value (anything but `nil` or `false`).
#      def pull_request_number?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #started_at returns a truthy value (anything but `nil` or `false`).
#      def started_at?
#        # This is a placeholder.
#      end
#  
#      # When the build finished.
#      def finished_at
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #finished_at returns a truthy value (anything but `nil` or `false`).
#      def finished_at?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #branch returns a truthy value (anything but `nil` or `false`).
#      def branch?
#        # This is a placeholder.
#      end
#  
#      # The commit the build is associated with.
#      def commit
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #commit returns a truthy value (anything but `nil` or `false`).
#      def commit?
#        # This is a placeholder.
#      end
#  
#      # List of jobs that are part of the build's matrix.
#      def jobs
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #jobs returns a truthy value (anything but `nil` or `false`).
#      def jobs?
#        # This is a placeholder.
#      end
#  
#      def stages
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #stages returns a truthy value (anything but `nil` or `false`).
#      def stages?
#        # This is a placeholder.
#      end
#  
#      def cancel(params = {})
#        # This is a placeholder.
#      end
#  
#      def restart(params = {})
#        # This is a placeholder.
#      end
#  
#      def jobs_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_jobs(params = {})
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Builds < Travis::Client::Collection
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::Caches < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.delete(params = {})
#        # This is a placeholder.
#      end
#  
#      # The string to match against the cache name.
#      def match
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #match returns a truthy value (anything but `nil` or `false`).
#      def match?
#        # This is a placeholder.
#      end
#  
#      # The branch the cache belongs to.
#      def branch
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #branch returns a truthy value (anything but `nil` or `false`).
#      def branch?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Commit < Travis::Client::Entity
#      # Commit mesage.
#      def message
#        # This is a placeholder.
#      end
#  
#      # Committer data.
#      def author
#        # This is a placeholder.
#      end
#  
#      # Value uniquely identifying the commit.
#      def id
#        # This is a placeholder.
#      end
#  
#      # Named reference the commit has in git.
#      def ref
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #message returns a truthy value (anything but `nil` or `false`).
#      def message?
#        # This is a placeholder.
#      end
#  
#      # Checksum the commit has in git and is identified by.
#      def sha
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #sha returns a truthy value (anything but `nil` or `false`).
#      def sha?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #ref returns a truthy value (anything but `nil` or `false`).
#      def ref?
#        # This is a placeholder.
#      end
#  
#      # URL to the commit's diff on GitHub.
#      def compare_url
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #compare_url returns a truthy value (anything but `nil` or `false`).
#      def compare_url?
#        # This is a placeholder.
#      end
#  
#      # Commit date from git.
#      def committed_at
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #committed_at returns a truthy value (anything but `nil` or `false`).
#      def committed_at?
#        # This is a placeholder.
#      end
#  
#      # Committer data.
#      def committer
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #committer returns a truthy value (anything but `nil` or `false`).
#      def committer?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #author returns a truthy value (anything but `nil` or `false`).
#      def author?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Cron < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.delete(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.create(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.for_branch(params = {})
#        # This is a placeholder.
#      end
#  
#      def find(params = {})
#        # This is a placeholder.
#      end
#  
#      def delete(params = {})
#        # This is a placeholder.
#      end
#  
#      # Value uniquely identifying the cron.
#      def id
#        # This is a placeholder.
#      end
#  
#      # Github repository to which this cron belongs.
#      def repository
#        # This is a placeholder.
#      end
#  
#      # Git branch of repository to which this cron belongs.
#      def branch
#        # This is a placeholder.
#      end
#  
#      # When the cron was created.
#      def created_at
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #repository returns a truthy value (anything but `nil` or `false`).
#      def repository?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #created_at returns a truthy value (anything but `nil` or `false`).
#      def created_at?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #branch returns a truthy value (anything but `nil` or `false`).
#      def branch?
#        # This is a placeholder.
#      end
#  
#      # Interval at which the cron will run (can be "daily", "weekly" or "monthly")
#      def interval
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #interval returns a truthy value (anything but `nil` or `false`).
#      def interval?
#        # This is a placeholder.
#      end
#  
#      # Whether a cron build should run if there has been a build on this branch in the last 24 hours.
#      def dont_run_if_recent_build_exists
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #dont_run_if_recent_build_exists returns a truthy value (anything but `nil` or `false`).
#      def dont_run_if_recent_build_exists?
#        # This is a placeholder.
#      end
#  
#      # When the cron ran last.
#      def last_run
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #last_run returns a truthy value (anything but `nil` or `false`).
#      def last_run?
#        # This is a placeholder.
#      end
#  
#      # When the cron is scheduled to run next.
#      def next_run
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #next_run returns a truthy value (anything but `nil` or `false`).
#      def next_run?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Crons < Travis::Client::Collection
#      def self.for_repository(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::EnvVar < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.delete(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.update(params = {})
#        # This is a placeholder.
#      end
#  
#      # The environment variable name, e.g. FOO.
#      def name
#        # This is a placeholder.
#      end
#  
#      def find(params = {})
#        # This is a placeholder.
#      end
#  
#      def delete(params = {})
#        # This is a placeholder.
#      end
#  
#      # The environment variable's value, e.g. bar.
#      def value
#        # This is a placeholder.
#      end
#  
#      # Whether this environment variable should be publicly visible or not.
#      def public
#        # This is a placeholder.
#      end
#  
#      def update(params = {})
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #value returns a truthy value (anything but `nil` or `false`).
#      def value?
#        # This is a placeholder.
#      end
#  
#      def id
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #public returns a truthy value (anything but `nil` or `false`).
#      def public?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #name returns a truthy value (anything but `nil` or `false`).
#      def name?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::EnvVars < Travis::Client::Collection
#      def self.create(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.for_repository(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::Error < Travis::Client::Entity
#      def self.default_message
#        # This is a placeholder.
#      end
#  
#      def self.default_message=(message)
#        # This is a placeholder.
#      end
#  
#      def self.entity_factory
#        # This is a placeholder.
#      end
#  
#      def self.exception
#        # This is a placeholder.
#      end
#  
#      # The error's message.
#      def error_message
#        # This is a placeholder.
#      end
#  
#      # The error's type.
#      def error_type
#        # This is a placeholder.
#      end
#  
#      # The error's resource type.
#      def resource_type
#        # This is a placeholder.
#      end
#  
#      # The error's permission.
#      def permission
#        # This is a placeholder.
#      end
#  
#      def entity
#        # This is a placeholder.
#      end
#  
#      def exception
#        # This is a placeholder.
#      end
#  
#      def message
#        # This is a placeholder.
#      end
#  
#      def backtrace
#        # This is a placeholder.
#      end
#  
#      def backtrace_locations
#        # This is a placeholder.
#      end
#  
#      def set_backtrace
#        # This is a placeholder.
#      end
#  
#      def cause
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Job < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.debug(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.cancel(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.restart(params = {})
#        # This is a placeholder.
#      end
#  
#      def find(params = {})
#        # This is a placeholder.
#      end
#  
#      # Current state of the job.
#      def state
#        # This is a placeholder.
#      end
#  
#      # GitHub user or organization the job belongs to.
#      def owner
#        # This is a placeholder.
#      end
#  
#      def log(params = {})
#        # This is a placeholder.
#      end
#  
#      # The build the job is associated with.
#      def build
#        # This is a placeholder.
#      end
#  
#      def debug(params = {})
#        # This is a placeholder.
#      end
#  
#      # Value uniquely identifying the job.
#      def id
#        # This is a placeholder.
#      end
#  
#      # Incremental number for a repository's builds.
#      def number
#        # This is a placeholder.
#      end
#  
#      # GitHub user or organization the job belongs to.
#      def repository
#        # This is a placeholder.
#      end
#  
#      # When the job started.
#      def started_at
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #repository returns a truthy value (anything but `nil` or `false`).
#      def repository?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #number returns a truthy value (anything but `nil` or `false`).
#      def number?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #state returns a truthy value (anything but `nil` or `false`).
#      def state?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #started_at returns a truthy value (anything but `nil` or `false`).
#      def started_at?
#        # This is a placeholder.
#      end
#  
#      # When the job finished.
#      def finished_at
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #finished_at returns a truthy value (anything but `nil` or `false`).
#      def finished_at?
#        # This is a placeholder.
#      end
#  
#      # The commit the job is associated with.
#      def commit
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #commit returns a truthy value (anything but `nil` or `false`).
#      def commit?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #build returns a truthy value (anything but `nil` or `false`).
#      def build?
#        # This is a placeholder.
#      end
#  
#      # Worker queue this job is/was scheduled on.
#      def queue
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #queue returns a truthy value (anything but `nil` or `false`).
#      def queue?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #owner returns a truthy value (anything but `nil` or `false`).
#      def owner?
#        # This is a placeholder.
#      end
#  
#      def stage
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #stage returns a truthy value (anything but `nil` or `false`).
#      def stage?
#        # This is a placeholder.
#      end
#  
#      def cancel(params = {})
#        # This is a placeholder.
#      end
#  
#      def restart(params = {})
#        # This is a placeholder.
#      end
#  
#      def log_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_log(params = {})
#        # This is a placeholder.
#      end
#  
#      def log_delete(params = {})
#        # This is a placeholder.
#      end
#  
#      def delete_log(params = {})
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Jobs < Travis::Client::Collection
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::KeyPair < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.delete(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.update(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.create(params = {})
#        # This is a placeholder.
#      end
#  
#      # The private key.
#      def value
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #value returns a truthy value (anything but `nil` or `false`).
#      def value?
#        # This is a placeholder.
#      end
#  
#      # A text description.
#      def description
#        # This is a placeholder.
#      end
#  
#      # The public key.
#      def public_key
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #public_key returns a truthy value (anything but `nil` or `false`).
#      def public_key?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #description returns a truthy value (anything but `nil` or `false`).
#      def description?
#        # This is a placeholder.
#      end
#  
#      # The fingerprint.
#      def fingerprint
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #fingerprint returns a truthy value (anything but `nil` or `false`).
#      def fingerprint?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::KeyPairGenerated < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.create(params = {})
#        # This is a placeholder.
#      end
#  
#      # A text description.
#      def description
#        # This is a placeholder.
#      end
#  
#      # The public key.
#      def public_key
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #public_key returns a truthy value (anything but `nil` or `false`).
#      def public_key?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #description returns a truthy value (anything but `nil` or `false`).
#      def description?
#        # This is a placeholder.
#      end
#  
#      # The fingerprint.
#      def fingerprint
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #fingerprint returns a truthy value (anything but `nil` or `false`).
#      def fingerprint?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Lint < Travis::Client::Entity
#      def self.lint(params = {})
#        # This is a placeholder.
#      end
#  
#      # An array of hashes with keys and warnings.
#      def warnings
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #warnings returns a truthy value (anything but `nil` or `false`).
#      def warnings?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Log < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.delete(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::Organization < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      # Name set on GitHub.
#      def name
#        # This is a placeholder.
#      end
#  
#      def find(params = {})
#        # This is a placeholder.
#      end
#  
#      def owner(params = {})
#        # This is a placeholder.
#      end
#  
#      def active(params = {})
#        # This is a placeholder.
#      end
#  
#      # Value uniquely identifying the organization.
#      def id
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #name returns a truthy value (anything but `nil` or `false`).
#      def name?
#        # This is a placeholder.
#      end
#  
#      # Login set on GitHub.
#      def login
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #login returns a truthy value (anything but `nil` or `false`).
#      def login?
#        # This is a placeholder.
#      end
#  
#      def github_id
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #github_id returns a truthy value (anything but `nil` or `false`).
#      def github_id?
#        # This is a placeholder.
#      end
#  
#      # Avatar_url set on GitHub.
#      def avatar_url
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #avatar_url returns a truthy value (anything but `nil` or `false`).
#      def avatar_url?
#        # This is a placeholder.
#      end
#  
#      # Repositories belonging to this organization.
#      def repositories
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #repositories returns a truthy value (anything but `nil` or `false`).
#      def repositories?
#        # This is a placeholder.
#      end
#  
#      def active_for_owner(params = {})
#        # This is a placeholder.
#      end
#  
#      def for_owner_active(params = {})
#        # This is a placeholder.
#      end
#  
#      def owner_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_owner(params = {})
#        # This is a placeholder.
#      end
#  
#      def repositories_for_owner(params = {})
#        # This is a placeholder.
#      end
#  
#      def for_owner_repositories(params = {})
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Organizations < Travis::Client::Collection
#      def self.for_current_user(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::Owner < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      # User or organization name set on GitHub.
#      def name
#        # This is a placeholder.
#      end
#  
#      def find(params = {})
#        # This is a placeholder.
#      end
#  
#      def active(params = {})
#        # This is a placeholder.
#      end
#  
#      # Value uniquely identifying the owner.
#      def id
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #name returns a truthy value (anything but `nil` or `false`).
#      def name?
#        # This is a placeholder.
#      end
#  
#      # User or organization login set on GitHub.
#      def login
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #login returns a truthy value (anything but `nil` or `false`).
#      def login?
#        # This is a placeholder.
#      end
#  
#      # User or organization id set on GitHub.
#      def github_id
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #github_id returns a truthy value (anything but `nil` or `false`).
#      def github_id?
#        # This is a placeholder.
#      end
#  
#      # Link to user or organization avatar (image) set on GitHub.
#      def avatar_url
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #avatar_url returns a truthy value (anything but `nil` or `false`).
#      def avatar_url?
#        # This is a placeholder.
#      end
#  
#      # Repositories belonging to this account.
#      def repositories
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #repositories returns a truthy value (anything but `nil` or `false`).
#      def repositories?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Repositories < Travis::Client::Collection
#      def self.for_owner(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.for_current_user(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::Repository < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.activate(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.deactivate(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.star(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.unstar(params = {})
#        # This is a placeholder.
#      end
#  
#      def key_pair(params = {})
#        # This is a placeholder.
#      end
#  
#      def key_pair_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_key_pair(params = {})
#        # This is a placeholder.
#      end
#  
#      def key_pair_create(params = {})
#        # This is a placeholder.
#      end
#  
#      def create_key_pair(params = {})
#        # This is a placeholder.
#      end
#  
#      def key_pair_update(params = {})
#        # This is a placeholder.
#      end
#  
#      def update_key_pair(params = {})
#        # This is a placeholder.
#      end
#  
#      def key_pair_delete(params = {})
#        # This is a placeholder.
#      end
#  
#      def caches(params = {})
#        # This is a placeholder.
#      end
#  
#      # The repository's name on GitHub.
#      def name
#        # This is a placeholder.
#      end
#  
#      # The repository's description from GitHub.
#      def description
#        # This is a placeholder.
#      end
#  
#      # Whether or not this repository is currently enabled on Travis CI.
#      def active
#        # This is a placeholder.
#      end
#  
#      def key_pair_generated(params = {})
#        # This is a placeholder.
#      end
#  
#      def key_pair_generated_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def delete_key_pair(params = {})
#        # This is a placeholder.
#      end
#  
#      def key_pair_generated_create(params = {})
#        # This is a placeholder.
#      end
#  
#      # Whether or not this repository is private.
#      def private
#        # This is a placeholder.
#      end
#  
#      def crons(params = {})
#        # This is a placeholder.
#      end
#  
#      def env_vars(params = {})
#        # This is a placeholder.
#      end
#  
#      def create_key_pair_generated(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_key_pair_generated(params = {})
#        # This is a placeholder.
#      end
#  
#      # Value uniquely identifying the repository.
#      def id
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #owner returns a truthy value (anything but `nil` or `false`).
#      def owner?
#        # This is a placeholder.
#      end
#  
#      def requests(params = {})
#        # This is a placeholder.
#      end
#  
#      def deactivate(params = {})
#        # This is a placeholder.
#      end
#  
#      def star(params = {})
#        # This is a placeholder.
#      end
#  
#      def unstar(params = {})
#        # This is a placeholder.
#      end
#  
#      def requests_find(params = {})
#        # This is a placeholder.
#      end
#  
#      # Same as {repository.owner.name}/{repository.name}
#      def slug
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #slug returns a truthy value (anything but `nil` or `false`).
#      def slug?
#        # This is a placeholder.
#      end
#  
#      # The main programming language used according to GitHub.
#      def github_language
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #github_language returns a truthy value (anything but `nil` or `false`).
#      def github_language?
#        # This is a placeholder.
#      end
#  
#      def starred
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #starred returns a truthy value (anything but `nil` or `false`).
#      def starred?
#        # This is a placeholder.
#      end
#  
#      def current_build
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #current_build returns a truthy value (anything but `nil` or `false`).
#      def current_build?
#        # This is a placeholder.
#      end
#  
#      def find(params = {})
#        # This is a placeholder.
#      end
#  
#      def setting(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_requests(params = {})
#        # This is a placeholder.
#      end
#  
#      def requests_create(params = {})
#        # This is a placeholder.
#      end
#  
#      def create_requests(params = {})
#        # This is a placeholder.
#      end
#  
#      def update_setting(params = {})
#        # This is a placeholder.
#      end
#  
#      def setting_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_setting(params = {})
#        # This is a placeholder.
#      end
#  
#      def setting_update(params = {})
#        # This is a placeholder.
#      end
#  
#      def branch_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_branch(params = {})
#        # This is a placeholder.
#      end
#  
#      def branches_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_branches(params = {})
#        # This is a placeholder.
#      end
#  
#      def builds(params = {})
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #name returns a truthy value (anything but `nil` or `false`).
#      def name?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #description returns a truthy value (anything but `nil` or `false`).
#      def description?
#        # This is a placeholder.
#      end
#  
#      def activate(params = {})
#        # This is a placeholder.
#      end
#  
#      def builds_find(params = {})
#        # This is a placeholder.
#      end
#  
#      # GitHub user or organization the repository belongs to.
#      def owner
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #default_branch returns a truthy value (anything but `nil` or `false`).
#      def default_branch?
#        # This is a placeholder.
#      end
#  
#      def find_caches(params = {})
#        # This is a placeholder.
#      end
#  
#      def branch(params = {})
#        # This is a placeholder.
#      end
#  
#      def caches_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def delete_caches(params = {})
#        # This is a placeholder.
#      end
#  
#      def branches(params = {})
#        # This is a placeholder.
#      end
#  
#      def settings(params = {})
#        # This is a placeholder.
#      end
#  
#      def caches_delete(params = {})
#        # This is a placeholder.
#      end
#  
#      # The default branch on GitHub.
#      def default_branch
#        # This is a placeholder.
#      end
#  
#      def cron(params = {})
#        # This is a placeholder.
#      end
#  
#      def cron_for_branch(params = {})
#        # This is a placeholder.
#      end
#  
#      def for_branch_cron(params = {})
#        # This is a placeholder.
#      end
#  
#      def cron_create(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_builds(params = {})
#        # This is a placeholder.
#      end
#  
#      def create_cron(params = {})
#        # This is a placeholder.
#      end
#  
#      def env_var(params = {})
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #private returns a truthy value (anything but `nil` or `false`).
#      def private?
#        # This is a placeholder.
#      end
#  
#      def env_var_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_env_var(params = {})
#        # This is a placeholder.
#      end
#  
#      def env_var_update(params = {})
#        # This is a placeholder.
#      end
#  
#      def update_env_var(params = {})
#        # This is a placeholder.
#      end
#  
#      def env_var_delete(params = {})
#        # This is a placeholder.
#      end
#  
#      def delete_env_var(params = {})
#        # This is a placeholder.
#      end
#  
#      def env_vars_create(params = {})
#        # This is a placeholder.
#      end
#  
#      def create_env_vars(params = {})
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #active returns a truthy value (anything but `nil` or `false`).
#      def active?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Request < Travis::Client::Entity
#      # Travis-ci status message attached to the request.
#      def message
#        # This is a placeholder.
#      end
#  
#      # The result returned after running the build (eg, passed, failed, canceled, etc)
#      def result
#        # This is a placeholder.
#      end
#  
#      # GitHub user or organization the request belongs to.
#      def owner
#        # This is a placeholder.
#      end
#  
#      # Value uniquely identifying the request.
#      def id
#        # This is a placeholder.
#      end
#  
#      # GitHub user or organization the request belongs to.
#      def repository
#        # This is a placeholder.
#      end
#  
#      # When Travis CI created the request.
#      def created_at
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #repository returns a truthy value (anything but `nil` or `false`).
#      def repository?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #message returns a truthy value (anything but `nil` or `false`).
#      def message?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #created_at returns a truthy value (anything but `nil` or `false`).
#      def created_at?
#        # This is a placeholder.
#      end
#  
#      # Origin of request (push, pull request, api)
#      def event_type
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #event_type returns a truthy value (anything but `nil` or `false`).
#      def event_type?
#        # This is a placeholder.
#      end
#  
#      # The commit the request is associated with.
#      def commit
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #commit returns a truthy value (anything but `nil` or `false`).
#      def commit?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #owner returns a truthy value (anything but `nil` or `false`).
#      def owner?
#        # This is a placeholder.
#      end
#  
#      def branch_name
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #branch_name returns a truthy value (anything but `nil` or `false`).
#      def branch_name?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #result returns a truthy value (anything but `nil` or `false`).
#      def result?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Requests < Travis::Client::Collection
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.create(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::Setting < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.update(params = {})
#        # This is a placeholder.
#      end
#  
#      # The setting's name.
#      def name
#        # This is a placeholder.
#      end
#  
#      def find(params = {})
#        # This is a placeholder.
#      end
#  
#      # The setting's value.
#      def value
#        # This is a placeholder.
#      end
#  
#      def update(params = {})
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #value returns a truthy value (anything but `nil` or `false`).
#      def value?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #name returns a truthy value (anything but `nil` or `false`).
#      def name?
#        # This is a placeholder.
#      end
#    end
#  
#    class Travis::Settings < Travis::Client::Collection
#      def self.for_repository(params = {})
#        # This is a placeholder.
#      end
#  
#    end
#  
#    class Travis::User < Travis::Client::Entity
#      def self.find(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.sync(params = {})
#        # This is a placeholder.
#      end
#  
#      def self.current(params = {})
#        # This is a placeholder.
#      end
#  
#      # Name set on GitHub.
#      def name
#        # This is a placeholder.
#      end
#  
#      def find(params = {})
#        # This is a placeholder.
#      end
#  
#      def sync(params = {})
#        # This is a placeholder.
#      end
#  
#      def owner(params = {})
#        # This is a placeholder.
#      end
#  
#      def active(params = {})
#        # This is a placeholder.
#      end
#  
#      # Value uniquely identifying the user.
#      def id
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #id returns a truthy value (anything but `nil` or `false`).
#      def id?
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #name returns a truthy value (anything but `nil` or `false`).
#      def name?
#        # This is a placeholder.
#      end
#  
#      def beta_features(params = {})
#        # This is a placeholder.
#      end
#  
#      # Login set on Github.
#      def login
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #login returns a truthy value (anything but `nil` or `false`).
#      def login?
#        # This is a placeholder.
#      end
#  
#      # Id set on GitHub.
#      def github_id
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #github_id returns a truthy value (anything but `nil` or `false`).
#      def github_id?
#        # This is a placeholder.
#      end
#  
#      # Avatar URL set on GitHub.
#      def avatar_url
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #avatar_url returns a truthy value (anything but `nil` or `false`).
#      def avatar_url?
#        # This is a placeholder.
#      end
#  
#      # Repositories belonging to this user.
#      def repositories
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #repositories returns a truthy value (anything but `nil` or `false`).
#      def repositories?
#        # This is a placeholder.
#      end
#  
#      # Whether or not the user is currently being synced with Github.
#      def is_syncing
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #is_syncing returns a truthy value (anything but `nil` or `false`).
#      def is_syncing?
#        # This is a placeholder.
#      end
#  
#      # The last time the user was synced with GitHub.
#      def synced_at
#        # This is a placeholder.
#      end
#  
#      # Wheather or not #synced_at returns a truthy value (anything but `nil` or `false`).
#      def synced_at?
#        # This is a placeholder.
#      end
#  
#      def active_for_owner(params = {})
#        # This is a placeholder.
#      end
#  
#      def for_owner_active(params = {})
#        # This is a placeholder.
#      end
#  
#      def beta_feature_update(params = {})
#        # This is a placeholder.
#      end
#  
#      def update_beta_feature(params = {})
#        # This is a placeholder.
#      end
#  
#      def beta_feature_delete(params = {})
#        # This is a placeholder.
#      end
#  
#      def delete_beta_feature(params = {})
#        # This is a placeholder.
#      end
#  
#      def beta_features_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_beta_features(params = {})
#        # This is a placeholder.
#      end
#  
#      def owner_find(params = {})
#        # This is a placeholder.
#      end
#  
#      def find_owner(params = {})
#        # This is a placeholder.
#      end
#  
#      def repositories_for_owner(params = {})
#        # This is a placeholder.
#      end
#  
#      def for_owner_repositories(params = {})
#        # This is a placeholder.
#      end
#    end

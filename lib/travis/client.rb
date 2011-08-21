require 'ostruct'
require 'optparse'
require 'hirb'

require 'travis/api'
require 'travis/client/repositories'

module Travis

   # Travis Command Line Client

  class Client

    # Tries to guess the repository based on the git remote urls
    # and prints its status.
    # If several remote repositories are defined it will display
    # the status of each of them. 
    def self.status
      ARGV[0] = 'repositories'
      slugs = target_repository_slugs()
      if slugs.length > 1
        ARGV << "--slugs=#{target_repository_slugs().join(',')}"
      else
        ARGV << "--slug=#{target_repository_slugs().first}"
      end
      Repositories.new.run
    end

    # Handles the given options and executes the requested command 
    def run
      handle_options()
      execute_operation()
    end

  private

    # Returns the list of repository slugs based on the current 
    # directory git remote repositories.
    #
    # @return [Array<String>]
    def self.target_repository_slugs
      %x[git remote -v].scan(/(?:\:|\/)([^\:\/]+\/[^\:\/]+)\.git/m).flatten.uniq
    end

    # Initializes and return the options as an OpenStruct instance
    #
    # @return [OpenStruct]
    def options 
      @options ||= OpenStruct.new
    end

    # Sets the options and creates the help layout.
    def handle_options
      OptionParser.new do |opts|
        opts.banner = 'Travis CI Command Line Client'

        setup_help(opts) {|opts|
          opts.separator ''
          opts.separator 'Supported Options:'
          client_options().each {|option| opts.on(*option)}
          opts.on_tail('--help', '-h', '-H', 'display this help message.') do
            $stdout.print opts
            exit
          end
        }
      end.parse!
    end
   
    # Sets up the custom help sections
    #
    # @param [OpenParser] opts The options parser
    def setup_help(opts)
      opts.separator ''
      opts.separator <<-USAGE
Usage:
   travis repositories|repos|rep|r {options}
   travis status|stat|s {options}
      USAGE
      opts.separator ''
      opts.separator <<-FURTHER_HELP
Furhter Help:
    travis {command} --help
      FURTHER_HELP

      yield(opts)
    end

    # Retuns the default options
    #
    # @return [Array<String>]
    def client_options 
      []
    end

    # Starts the execution of the previousy requested
    # command or rise and exception if the target operation
    # to be executed can not be identified.
    def execute_operation
      unless options().target
        raise 'Nothing to do ...'      
      end

      self.send(options().target)
    end

  end

end


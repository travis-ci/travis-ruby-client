require 'ostruct'
require 'optparse'
require 'hirb'

require 'travis/api'
require 'travis/client/repositories'

module Travis

  class Client

    def self.status
      target_repository_slugs()
      ARGV[0] = 'repositories'
      ARGV << "--slugs=#{target_repository_slugs().join(',')}"
      Repositories.new.run
    end

    def run
      handle_options()
      execute_operation()
    end

  private

    def self.target_repository_slugs
      %x[git remote -v].scan(/(?:\:|\/)([^\:\/]+\/[^\:\/]+)\.git/m).flatten.uniq
    end

    def options 
      @options ||= OpenStruct.new
    end

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
   
    def setup_help(opts)
      opts.separator ''
      opts.separator <<-USAGE
Usage:
   travis repositories {options}
   travis status {options}
      USAGE
      opts.separator ''
      opts.separator <<-FURTHER_HELP
Furhter Help:
    travis repositories --help
    travis status --help
      FURTHER_HELP

      yield(opts)
    end

    def client_options 
      []
    end

    def execute_operation
      unless options().target
        raise 'Nothing to do ...'      
      end

      self.send(options().target)
    end

  end

end


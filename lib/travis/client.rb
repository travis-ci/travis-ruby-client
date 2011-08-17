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
        client_options().each {|option| opts.on(*option)}
      end.parse!
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


require 'ostruct'
require 'optparse'
require 'hirb'

require 'travis/api'
require 'travis/client/repositories'

module Travis

  class Client

    def run
      handle_options()
      execute_operation()
    end

  private

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


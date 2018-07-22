require "hashie"
require "awesome_print"

module MemoryMongo
  module Extensions
    module MessageDispatcher
      class MashWithoutWarnings < Hashie::Mash
        disable_warnings
      end

      def dispatch_message(server)
        if MemoryMongo.disabled?
          puts "=================================="
          puts 'request spec:'
          ap @spec
          reply = super
          puts "reply:"
          ap reply
          reply
        else
          dispatch_message_in_memory
        end
      end

      def memory_server
        MemoryMongo::Server.instance
      end

      def req
        @req ||= MashWithoutWarnings.new(@spec)
      end
    end
  end
end

module MemoryMongo
  module Extensions
    module Connection
      def dispatch(messages, operation_id = nil)
        if MemoryMongo.enabled?
          ap messages
          raise NotImplementedError, 'operations is not implemented'
        else
          super
        end
      end
    end

    Mongo::Server::Connection.prepend(Connection)
  end
end

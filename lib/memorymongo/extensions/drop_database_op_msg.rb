module MemoryMongo
  module Extensions
    module DropDatabaseOpMsg
      include MessageDispatcher

      def dispatch_message_in_memory
        memory_server.drop_database(req.db_name)
        FakeReply.new([{dropped: req.db_name, ok: 1.0}])
      end
    end

    Mongo::Operation::DropDatabase::OpMsg.prepend(DropDatabaseOpMsg)
  end
end

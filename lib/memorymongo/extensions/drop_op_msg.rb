module MemoryMongo
  module Extensions
    module DropOpMsg
      include MessageDispatcher

      def dispatch_message_in_memory
        collection_name = req.selector['drop']
        memory_server.get_database(req.db_name).drop_collection(collection_name)
        FakeReply.new([{ns: "#{req.db_name}.#{collection_name}", nIndexesWas: 1, ok: 1.0}])
      end
    end

    Mongo::Operation::Drop::OpMsg.prepend(DropOpMsg)
  end
end

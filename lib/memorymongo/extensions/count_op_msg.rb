module MemoryMongo
  module Extensions
    module CountOpMsg
      include MessageDispatcher

      def dispatch_message_in_memory
        collection = memory_server.get_collection(req.db_name, req.selector['count'])
        docs = collection.filter_documents(req.selector.query)
        FakeReply.new([{n: docs.count, ok: 1.0}])
      end
    end

    Mongo::Operation::Count::OpMsg.prepend(CountOpMsg)
  end
end

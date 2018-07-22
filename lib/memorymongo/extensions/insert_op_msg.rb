module MemoryMongo
  module Extensions
    module InsertOpMsg
      include MessageDispatcher

      def dispatch_message_in_memory
        collection = memory_server.get_collection(req.db_name, req.coll_name)
        req.documents.each do |doc|
          collection.insert(doc)
        end

        FakeReply.new([{n: 1, ok: 1.0}])
      end
    end

    Mongo::Operation::Insert::OpMsg.prepend(InsertOpMsg)
  end
end

module MemoryMongo
  module Extensions
    module UpdateOpMsg
      include MessageDispatcher

      def dispatch_message_in_memory
        collection = memory_server.get_collection(req.db_name, req.coll_name)

        count = req.updates.sum do |dlt|
          collection.update_documents(dlt.q, dlt.u).count
        end

        FakeReply.new([{n: count, nModified: count, ok: 1.0}])
      end
    end

    Mongo::Operation::Update::OpMsg.prepend(UpdateOpMsg)
  end
end

module MemoryMongo
  module Extensions
    module DeleteOpMsg
      include MessageDispatcher

      def dispatch_message_in_memory
        collection = memory_server.get_collection(req.db_name, req.coll_name)

        count = req.deletes.sum do |delete|
          collection.delete_documents(delete.q).count
        end

        FakeReply.new([{n: count, ok: 1.0}])
      end
    end

    Mongo::Operation::Delete::OpMsg.prepend(DeleteOpMsg)
  end
end

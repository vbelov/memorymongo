module MemoryMongo
  module Extensions
    module FindOpMsg
      include MessageDispatcher

      def dispatch_message_in_memory
        collection = memory_server.get_collection(req.db_name, req.selector['find'])
        docs = collection.filter_documents(req.selector.filter)

        FakeReply.new([
            {
                cursor: {
                    firstBatch: docs.map(&:body),
                    id: 0,
                    ns: collection.ns,
                },
                ok: 1.0,
            }
        ])
      end
    end

    Mongo::Operation::Find::OpMsg.prepend(FindOpMsg)
  end
end

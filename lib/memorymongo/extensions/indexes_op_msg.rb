module MemoryMongo
  module Extensions
    module IndexesOpMsg
      include MessageDispatcher

      def dispatch_message_in_memory
        collection = memory_server.get_collection(req.db_name, req.coll_name)
        FakeReply.new([
                          {
                              cursor: {
                                  id: 0,
                                  ns: "#{req.db_name}.$cmd.listIndexes.#{req.coll_name}",
                                  firstBatch: collection.indices.map(&:to_hash)
                              },
                              ok: 1.0
                          }
                      ])
      end
    end

    Mongo::Operation::Indexes::OpMsg.prepend(IndexesOpMsg)
  end
end

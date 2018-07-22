module MemoryMongo
  module Extensions
    module CreateIndexOpMsg
      include MessageDispatcher

      def dispatch_message_in_memory
        collection = memory_server.get_collection(req.db_name, req.coll_name)
        before = collection.indices.count
        req.indexes.each do |index|
          collection.add_index(index.to_hash)
        end

        FakeReply.new([{
                           createdCollectionAutomatically: true,
                           numIndexesBefore: before,
                           numIndexesAfter: collection.indices.count,
                           ok: 1.0
                       }])
      end
    end

    Mongo::Operation::CreateIndex::OpMsg.prepend(CreateIndexOpMsg)
  end
end

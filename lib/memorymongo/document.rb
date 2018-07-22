module MemoryMongo
  class Document
    include Virtus::Model

    attribute :collection, Collection
    attribute :body, Hash

    def id
      body['_id']
    end
  end
end

module MemoryMongo
  class Database
    include Virtus::Model

    attribute :name, String
    attribute :server, Server

    def initialize(opts = {})
      super
      @collections = {}
    end

    def get_collection(collection_name)
      @collections[collection_name] ||= MemoryMongo::Collection.new(name: collection_name, database: self)
    end

    def drop_collection(collection_name)
      @collections.delete(collection_name)
    end
  end
end

module MemoryMongo
  class Index
    include Virtus::Model

    attribute :collection, Collection
    attribute :key, Hash
    attribute :name, String
    attribute :background, Boolean

    def to_hash
      {
          v: 2,
          key: key,
          name: name,
          ns: collection.ns,
          background: false,
      }.stringify_keys
    end
  end
end

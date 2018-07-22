module MemoryMongo
  class Server
    include Virtus::Model
    include Singleton

    def initialize(opts = {})
      super
      @databases = {}
    end

    def get_database(database_name)
      @databases[database_name] ||= Database.new(name: database_name, server: self)
    end

    def get_collection(database_name, collection_name)
      get_database(database_name).get_collection(collection_name)
    end

    def drop_database(database_name)
      @databases.delete(database_name)
    end

    def clear
      @databases = {}
    end
  end
end

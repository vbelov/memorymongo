module MemoryMongo
  class Collection
    include Virtus::Model

    attribute :name, String
    attribute :database, Database
    attribute :indices, Array

    def initialize(opts = {})
      super
      @documents = {}

      @indices = []
      @indices << Index.new(collection: self, key: {"_id" => 1}, name: '_id_')
    end

    def insert(document_body)
      id = document_body['_id']
      if @documents.key?(id)
        raise "document #{id} already exists"
      else
        @documents[id] = Document.new(collection: self, body: document_body)
      end
    end

    def ns
      "#{database.name}.#{name}"
    end

    def filter_documents(filter)
      @documents.values.select do |doc|
        DocumentFilter.new(doc).matches?(filter)
      end
    end

    def delete_documents(filter)
      docs = filter_documents(filter)
      docs.each do |doc|
        @documents.delete(doc.id)
      end
    end

    def update_documents(filter, update_spec)
      docs = filter_documents(filter)
      docs.each do |doc|
        update_hash = update_spec['$set']
        doc.body.merge!(update_hash)
      end
    end

    def add_index(options)
      @indices << Index.new(options.merge(collection: self))
    end
  end
end

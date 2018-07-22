module MemoryMongo
  class DocumentFilter
    attr_reader :body

    def initialize(doc)
      @body = doc.body
    end

    def matches?(filter)
      generic_filter(filter)
    end

    private

    def generic_filter(filter)
      key = filter.keys.first
      if key == '$or'
        _or(filter[key])
      else
        simple_filter(filter)
      end
    end

    def simple_filter(filter)
      filter.all? do |key, val|
        body[key] == val
      end
    end

    def _or(filters)
      filters = Array.wrap(filters)
      filters.any? {|f| generic_filter(f)}
    end
  end
end

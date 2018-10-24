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
        if val.is_a?(Hash)
          condition, values = val.first
          if condition == '$in'
            body[key].in?(values)
          elsif condition == '$ne'
            body[key] != values
          else
            raise NotImplementedError, "Cannot apply filter #{filter.inspect}. Unknown filter condition: #{condition}"
          end
        else
          body[key] == val
        end
      end
    end

    def _or(filters)
      filters = Array.wrap(filters)
      filters.any? {|f| generic_filter(f)}
    end
  end
end

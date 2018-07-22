module MemoryMongo
  module Extensions
    class FakeReply
      attr_reader :documents

      def initialize(docs)
        @documents =
          if docs.is_a?(Array)
            docs.map(&:deep_stringify_keys)
          else
            docs.deep_stringify_keys
          end
      end

      def number_returned
        @documents.count
      end
    end
  end
end

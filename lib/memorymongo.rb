require "memorymongo/engine"
require "mongoid"

module MemoryMongo
  class << self
    def enabled?
      @enabled
    end

    def disabled?
      !@enabled
    end

    def enable!
      inspect_mongo_requests!
      @enabled = true
    end

    def disable!
      @enabled = false
    end

    def inspect_mongo_requests!
      return if @installed

      require 'virtus'

      require_relative 'memorymongo/extensions/connection'
      require_relative 'memorymongo/extensions/count_op_msg'
      require_relative 'memorymongo/extensions/create_index_op_msg'
      require_relative 'memorymongo/extensions/delete_op_msg'
      require_relative 'memorymongo/extensions/drop_database_op_msg'
      require_relative 'memorymongo/extensions/drop_op_msg'
      require_relative 'memorymongo/extensions/find_op_msg'
      require_relative 'memorymongo/extensions/indexes_op_msg'
      require_relative 'memorymongo/extensions/insert_op_msg'
      require_relative 'memorymongo/extensions/update_op_msg'

      @installed = true
    end
  end

  module Extensions
    autoload :FakeReply,         'memorymongo/extensions/fake_reply'
    autoload :MessageDispatcher, 'memorymongo/extensions/message_dispatcher'
  end

  autoload :Collection,     'memorymongo/collection'
  autoload :Database,       'memorymongo/database'
  autoload :Document,       'memorymongo/document'
  autoload :DocumentFilter, 'memorymongo/document_filter'
  autoload :Index,          'memorymongo/index'
  autoload :Server,         'memorymongo/server'
end

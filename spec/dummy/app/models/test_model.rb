class TestModel
  include Mongoid::Document

  field :string_field, type: String
  field :int_field, type: Integer
  field :bool_field, type: Boolean
end

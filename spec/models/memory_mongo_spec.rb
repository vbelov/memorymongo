# MemoryMongo.inspect_mongo_requests!
MemoryMongo.enable!


RSpec.describe MemoryMongo, type: :model do
  around(:each) do |example|
    begin
      example.run
    ensure
      Mongoid::Clients.default.database.drop
    end
  end


  it 'finds document by id' do
    model1 = TestModel.create!(string_field: 'str1')
    model2 = TestModel.create!(string_field: 'str2')
    model = TestModel.find(model2.id)
    expect(model).to eq(model2)
  end

  it 'allows to count documents matching filter' do
    TestModel.create!(int_field: 1)
    TestModel.create!(int_field: 1)
    expect(TestModel.where(int_field: 1).count).to eq(2)
  end

  it 'allows to use AND within filter' do
    TestModel.create!(int_field: 1, bool_field: true)
    TestModel.create!(int_field: 1, bool_field: false)
    expect(TestModel.where(int_field: 1, bool_field: false).count).to eq(1)
  end

  it 'allows to use OR within filter' do
    TestModel.create!(int_field: 1)
    TestModel.create!(int_field: 2)
    expect(TestModel.or({int_field: 1}, {int_field: 2}).count).to eq(2)
    expect(TestModel.or({int_field: 1}, {int_field: 3}).count).to eq(1)
  end

  it 'returns documents matching filter' do
    TestModel.create!(int_field: 1)
    TestModel.create!(int_field: 2)
    TestModel.create!(int_field: 3)
    expect(TestModel.or({int_field: 1}, {int_field: 2}).all.map(&:int_field)).to match_array([1, 2])
  end

  it 'update allows to set new field value' do
    model = TestModel.create!(string_field: 'str1')
    model.update!(int_field: 1)
    expect(model.reload.string_field).to eq('str1')
    expect(model.reload.int_field).to eq(1)
  end

  it 'update allows to nullify field value' do
    model = TestModel.create!(string_field: 'str1')
    model.update!(string_field: nil)
    expect(model.reload.string_field).to be nil
  end

  it 'deletes document' do
    model = TestModel.create!(string_field: 'str1')
    model.destroy
    expect(TestModel.where(id: model.id).first).to be nil
  end

  it 'deletes all documents' do
    TestModel.create!(int_field: 1)
    TestModel.create!(int_field: 2)
    TestModel.delete_all
    expect(TestModel.count).to eq(0)
  end

  it 'drops collection' do
    TestModel.create!(int_field: 1)
    TestModel.collection.drop
    expect(TestModel.count).to eq(0)
  end

  it 'drops database' do
    TestModel.create!(string_field: 'str1')
    Mongoid::Clients.default.database.drop
    expect(TestModel.count).to eq(0)
  end

  it 'creates index' do
    TestModel.index(int_field: 1)
    TestModel.create_indexes
    indices = TestModel.collection.indexes.to_a
    expect(indices.count).to eq(2)
    index = indices.last
    expect(index['key']['int_field']).to eq(1)
    expect(index['name']).to eq('int_field_1')
  end
end

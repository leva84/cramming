describe ModelBase do
  let(:attributes) { { id: 1, ru: 'ru', en: 'en' } }
  let(:model_base) { described_class.new(attributes) }
  let(:invalid_attribute) { 'invalid_attribute' }

  shared_examples :not_implemented_error do
    it 'returns raise error' do
      expect { described_class.send(method_name) }.to raise_error(NotImplementedError)
    end
  end

  describe '.method_missing' do
    before { allow(described_class).to receive(:attributes_keys).and_return(attributes.keys) }

    context 'when the method name is not a key in the attributes' do
      it 'returns raise error' do
        expect { model_base.send(invalid_attribute) }.to raise_error(NoMethodError)
      end
    end
  end

  describe '.db' do
    it 'returns the test database' do
      expect(described_class.db.filename).to include '/cramming/test.db'
    end
  end

  describe '.table_name' do
    let(:method_name) { 'table_name' }

    it_behaves_like :not_implemented_error
  end
end

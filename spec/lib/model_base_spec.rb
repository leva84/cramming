describe ModelBase do
  let(:attributes) { { id: 1, ru: 'ru', en: 'en' } }
  let(:model_base) { described_class.new(attributes) }
  let(:invalid_attribute) { 'invalid_attribute' }

  shared_examples :not_implemented_error do
    it 'returns raise error' do
      expect { described_class.send(method_name) }.to raise_error(NotImplementedError)
    end
  end

  describe '#initialize' do
    before { allow(described_class).to receive(:attributes_keys).and_return(attributes.keys) }

    it 'assigns attributes and values' do
      expect(model_base.instance_variable_get(:@id)).to eq(attributes[:id])
      expect(model_base.instance_variable_get(:@ru)).to eq(attributes[:ru])
      expect(model_base.instance_variable_get(:@en)).to eq(attributes[:en])
    end

    it 'defines methods for each attribute' do
      attributes.each_key do |key|
        expect(model_base).to respond_to(key)
      end
    end
  end

  describe '#data_key' do
    before { allow(described_class).to receive(:attributes_keys).and_return(attributes.keys) }

    it 'calls the class method data_key and returns its value' do
      allow(described_class).to receive(:data_key).and_return('test_data_key')
      expect(model_base.send(:data_key)).to eq('test_data_key')
    end
  end

  describe '.method_missing' do
    before { allow(described_class).to receive(:attributes_keys).and_return(attributes.keys) }

    context 'when the method name is a key in attributes' do
      it 'returns the value of the attribute' do
        attributes.each do |key, value|
          expect(model_base.send(key)).to eq(value)
        end
      end
    end

    context 'when the method name is not a key in the attributes' do
      it 'returns raise error' do
        expect { model_base.send(invalid_attribute) }.to raise_error(NoMethodError)
      end
    end
  end

  describe '.respond_to_missing?' do
    before { allow(described_class).to receive(:attributes_keys).and_return(attributes.keys) }

    context 'when the method name is a key in attributes' do
      it 'returns true' do
        attributes.each_key do |key|
          expect(model_base.respond_to?(key)).to be_truthy
        end
      end
    end

    context 'when the method name is not a key in the attributes' do
      it 'returns raise error' do
        expect(model_base.respond_to?(invalid_attribute)).to be_falsey
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

  describe '.data_key' do
    let(:method_name) { 'data_key' }

    it_behaves_like :not_implemented_error
  end

  describe '.query_template' do
    let(:method_name) { 'query_template' }

    it_behaves_like :not_implemented_error
  end

  describe '.attributes_keys' do
    let(:method_name) { 'attributes_keys' }

    it_behaves_like :not_implemented_error
  end
end

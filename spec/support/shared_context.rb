shared_context :with_class_methods_for_composite_model do
  let(:table_name) { described_class.table_name }

  describe '.attributes_keys' do
    it 'has id attribute' do
      expect(described_class.attributes_keys.include?(:id)).to be_truthy
    end
  end

  describe '.query_template' do
    it 'returns a query template with the correct columns' do
      expect(described_class.query_template).to eq("SELECT #{ described_class.attributes_keys.join(', ') } FROM #{ table_name }")
    end
  end
end

shared_context :with_instance_methods_for_composite_model do
  let!(:instance) { described_class.all.sample }
  let(:attributes_keys) { described_class.attributes_keys - [:id] }

  describe '#initialize' do
    context 'when valid attributes' do
      let(:attributes) { attributes_keys.map { |key| [key, 'some_value'] }.to_h }

      it 'returns blank model' do
        expect(described_class.new(attributes)).to be_truthy
        expect(described_class.new(attributes).id).to be_nil
      end

      it 'returns an instance of the described class' do
        expect(described_class.new(attributes)).to be_a(described_class)
      end
    end

    context 'when invalid attributes' do
      let(:attributes) { { attribute1: 'invalid1', attribute2: 'invalid2' } }

      it 'returns raise error' do
        expect { described_class.new(attributes) }.to raise_error(NoMethodError, /undefined method `attribute1=' for/)
      end
    end
  end

  describe '#update' do
    let(:new_value) { 'new_value' }

    context 'when valid attributes' do
      let(:attributes) { attributes_keys.map { |key| [key, new_value] }.to_h }

      it 'updates a model instance' do
        expect(instance.update(attributes)).to be_truthy
        expect(described_class.find(instance.id).send(attributes_keys.sample)).to eq(new_value)
      end
    end

    context 'when invalid attributes' do
      let(:attributes) { { attribute1: 'invalid1', attribute2: 'invalid2' } }

      it 'returns raise error' do
        expect { instance.update(attributes) }.to raise_error(SQLite3::SQLException, /no such column: attribute1/)
        expect(described_class.find(instance.id).send(attributes_keys.sample)).not_to eq(new_value)
      end
    end
  end

  describe '#delete' do
    it 'deletes a model instance' do
      expect(instance.delete).to be_truthy
      expect(described_class.find(instance.id)).to be_nil
    end
  end
end

shared_context :with_query_methods_in_the_database do
  let(:attributes_keys) { described_class.attributes_keys - [:id] }

  describe '.new' do
    it 'returns blank model' do
      expect(described_class.new).to be_truthy
      expect(described_class.new.id).to be_nil
    end

    it 'returns an instance of the described class' do
      expect(described_class.new).to be_a(described_class)
    end
  end

  describe '.create' do
    context 'when valid attributes' do
      let(:attributes) { attributes_keys.each_with_object({}) { |k, h| h[k] = 'value' } }

      it 'creates a model instance' do
        expect(described_class.create(attributes)).to be_truthy
      end
    end

    context 'when invalid attributes' do
      let(:attributes) { { attribute1: 'invalid1', attribute2: 'invalid2' } }

      it 'returns raise error' do
        expect { described_class.create(attributes) }.to raise_error(SQLite3::SQLException, /no column named attribute1/)
      end
    end
  end

  describe '.all' do
    it 'returns described_class collection' do
      expect(described_class.all.is_a?(Array)).to be_truthy
    end

    it do
      expect(described_class.all.all? { |instance| instance.is_a?(described_class) }).to be_truthy
    end
  end

  describe '.find' do
    let(:expected_id) { described_class.all.first.id }

    it 'returns an instance of the described class' do
      expect(described_class.find(expected_id)).to be_a(described_class)
    end

    it 'returns exist in the database record' do
      expect(described_class.find(expected_id)).to be_truthy
    end

    it 'model attribute methods are called' do
      expect(attributes_keys.all? { |attribute| described_class.find(expected_id).send(attribute.to_s) }).to be_truthy
    end
  end

  describe '.find_by' do
    context 'when valid attributes' do
      let!(:expected_instance) { described_class.all.first }
      let(:searched_attribute) { attributes_keys.sample }
      let(:searched_value) { expected_instance.send(searched_attribute) }
      let(:query_hash) { { searched_attribute => searched_value } }

      it 'returns an instance of the described class' do
        expect(described_class.find_by(query_hash)).to be_a(described_class)
      end

      it 'returns exist in the database record' do
        expect(described_class.find_by(query_hash)).to be_truthy
      end

      it 'returns expected instance' do
        expect(described_class.find_by(query_hash).id).to eq(expected_instance.id)
      end
    end

    context 'when invalid attributes' do
      let(:attributes) { { attribute1: 'invalid1', attribute2: 'invalid2' } }

      it 'returns raise error' do
        expect { described_class.find_by(attributes) }.to raise_error(SQLite3::SQLException, /no such column: attribute1/)
      end
    end
  end

  describe '.where' do
    context 'when valid attributes' do
      let!(:expected_instance) { described_class.all.first }
      let(:searched_attributes) { attributes_keys.sample(2) }
      let(:searched_value1) { expected_instance.send(searched_attributes.first) }
      let(:searched_value2) { expected_instance.send(searched_attributes.last) }
      let(:query_hash) { { searched_attributes.first => searched_value1, searched_attributes.last => searched_value2 } }

      it 'returns described_class collection' do
        expect(described_class.all).to be_a(Array)
      end

      it 'returns expected instance' do
        expect(described_class.where(query_hash).first.id).to eq(expected_instance.id)
      end
    end

    context 'when invalid attributes' do
      let(:attributes) { { attribute1: 'invalid1', attribute2: 'invalid2' } }

      it 'returns raise error' do
        expect { described_class.where(attributes) }.to raise_error(SQLite3::SQLException, /no such column: attribute1/)
      end
    end
  end
end

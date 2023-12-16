describe ModelBase do
  let(:attributes) { { id: 1, ru: 'ru', en: 'en' } }
  let(:model_base) { described_class.new(attributes) }

  describe '#initialize' do
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

  describe '#method_missing' do
    context 'when the method name is a key in attributes' do
      it 'returns the value of the attribute' do
        attributes.each do |key, value|
          expect(model_base.send(key)).to eq(value)
        end
      end
    end
  end

  describe '#respond_to_missing?' do
    context 'when the method name is a key in attributes' do
      it 'returns true' do
        attributes.each_key do |key|
          expect(model_base.respond_to?(key)).to be(true)
        end
      end
    end
  end

  describe '#db' do
    it 'returns the test database' do
      expect(described_class.db.filename).to include '/cramming/test.db'
    end
  end
end

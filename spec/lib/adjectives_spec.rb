describe Adjectives do
  describe Adjectives::AdjectivesBase do
    it 'has a table name of "adjectives"' do
      expect(described_class.table_name).to eq('adjectives')
    end
  end

  describe Adjectives::Adjective do
    it 'has a data key of "adjective"' do
      expect(described_class.data_key).to eq('adjective')
    end

    include_context :with_class_methods_for_composite_model
    include_context :with_instance_methods_for_composite_model
    include_context :with_query_methods_in_the_database
  end

  describe Adjectives::Comparative do
    it 'has a data key of "comparative"' do
      expect(described_class.data_key).to eq('comparative')
    end

    include_context :with_class_methods_for_composite_model
    include_context :with_instance_methods_for_composite_model
    include_context :with_query_methods_in_the_database
  end

  describe Adjectives::Superlative do
    it 'has a data key of "superlative"' do
      expect(described_class.data_key).to eq('superlative')
    end

    include_context :with_class_methods_for_composite_model
    include_context :with_instance_methods_for_composite_model
    include_context :with_query_methods_in_the_database
  end
end

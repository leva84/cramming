describe Adjectives do
  describe Adjectives::AdjectivesBase do
    it 'has a table name of "adjectives"' do
      expect(described_class.table_name).to eq('adjectives')
    end
  end

  describe Adjectives::Adjective do
    include_context :with_class_methods_for_composite_model
    include_context :with_instance_methods_for_composite_model
    include_context :with_query_methods_in_the_database
  end

  describe Adjectives::Comparative do
    include_context :with_class_methods_for_composite_model
    include_context :with_instance_methods_for_composite_model
    include_context :with_query_methods_in_the_database
  end

  describe Adjectives::Superlative do
    include_context :with_class_methods_for_composite_model
    include_context :with_instance_methods_for_composite_model
    include_context :with_query_methods_in_the_database
  end
end

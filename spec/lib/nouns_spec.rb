describe Nouns do
  describe Nouns::NounsBase do
    it 'has a table name of "nouns"' do
      expect(described_class.table_name).to eq('nouns')
    end
  end

  describe Nouns::Noun do
    it 'has a data key of "noun"' do
      expect(described_class.data_key).to eq('noun')
    end

    include_context :with_class_methods_for_composite_model
    include_context :with_instance_methods_for_composite_model
    include_context :with_query_methods_in_the_database
  end

  describe Nouns::Plural do
    it 'has a data key of "plural"' do
      expect(described_class.data_key).to eq('plural')
    end

    include_context :with_class_methods_for_composite_model
    include_context :with_instance_methods_for_composite_model
    include_context :with_query_methods_in_the_database
  end
end

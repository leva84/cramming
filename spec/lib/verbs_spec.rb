describe Verbs do
  describe Verbs::VerbsBase do
    it 'has a table name of "verbs"' do
      expect(described_class.table_name).to eq('verbs')
    end
  end

  describe Verbs::Verb do
    it 'has a data key of "verb"' do
      expect(described_class.data_key).to eq('verb')
    end

    include_context :with_class_methods_for_composite_model
    include_context :with_query_methods_in_the_database
    include_context :with_instance_methods_for_composite_model
  end

  describe Verbs::SimplePast do
    it 'has a data key of "simple_past"' do
      expect(described_class.data_key).to eq('simple_past')
    end

    include_context :with_class_methods_for_composite_model
    include_context :with_query_methods_in_the_database
    include_context :with_instance_methods_for_composite_model
  end

  describe Verbs::PastParticiple do
    it 'has a data key of "past_participle"' do
      expect(described_class.data_key).to eq('past_participle')
    end

    include_context :with_class_methods_for_composite_model
    include_context :with_query_methods_in_the_database
    include_context :with_instance_methods_for_composite_model
  end
end

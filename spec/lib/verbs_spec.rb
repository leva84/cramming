describe Verbs do
  describe Verbs::VerbsBase do
    it 'has a table name of "verbs"' do
      expect(described_class.table_name).to eq('verbs')
    end
  end

  describe Verbs::Verb do
    include_context :with_class_methods_for_composite_model
    include_context :with_query_methods_in_the_database
    include_context :with_instance_methods_for_composite_model
  end

  describe Verbs::SimplePast do
    include_context :with_class_methods_for_composite_model
    include_context :with_query_methods_in_the_database
    include_context :with_instance_methods_for_composite_model
  end

  describe Verbs::PastParticiple do
    include_context :with_class_methods_for_composite_model
    include_context :with_query_methods_in_the_database
    include_context :with_instance_methods_for_composite_model
  end
end

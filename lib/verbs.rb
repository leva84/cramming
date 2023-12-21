module Verbs
  class VerbsBase < ModelBase
    def self.table_name
      'verbs'
    end
  end

  class Verb < VerbsBase
    set_column_names_and_types_for_model verb_ru: 'VARCHAR(255)', verb_en: 'VARCHAR(255)'
  end

  class SimplePast < VerbsBase
    set_column_names_and_types_for_model simple_past_ru: 'VARCHAR(255)', simple_past_en: 'VARCHAR(255)'
  end

  class PastParticiple < VerbsBase
    set_column_names_and_types_for_model past_participle_ru: 'VARCHAR(255)', past_participle_en: 'VARCHAR(255)'
  end
end

module Nouns
  class NounsBase < ModelBase
    def self.table_name
      'nouns'
    end
  end

  class Noun < NounsBase
    set_column_names_and_types_for_model noun_ru: 'VARCHAR(255)', noun_en: 'VARCHAR(255)'
  end

  class Plural < NounsBase
    set_column_names_and_types_for_model plural_ru: 'VARCHAR(255)', plural_en: 'VARCHAR(255)'
  end
end

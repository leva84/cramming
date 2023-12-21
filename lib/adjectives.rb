module Adjectives
  class AdjectivesBase < ModelBase
    def self.table_name
      'adjectives'
    end
  end

  class Adjective < AdjectivesBase
    set_column_names_and_types_for_model adjective_ru: 'VARCHAR(255)', adjective_en: 'VARCHAR(255)'
  end

  class Comparative < AdjectivesBase
    set_column_names_and_types_for_model comparative_ru: 'VARCHAR(255)', comparative_en: 'VARCHAR(255)'
  end

  class Superlative < AdjectivesBase
    set_column_names_and_types_for_model superlative_ru: 'VARCHAR(255)', superlative_en: 'VARCHAR(255)'
  end
end

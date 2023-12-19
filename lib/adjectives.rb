module Adjectives
  class AdjectivesBase < ModelBase
    class << self
      def table_name
        'adjectives'
      end

      def column_names_and_types
        { id: 'INTEGER PRIMARY KEY' }
      end

      def attributes_keys
        super

        @attributes_keys.select { |key| key == :id || key.to_s.start_with?("#{ data_key }_") }
      end

      def query_template
        @query_template ||= "SELECT id, #{ data_key }_ru, #{ data_key }_en FROM #{ table_name }"
      end
    end
  end

  class Adjective < AdjectivesBase
    class << self
      def data_key
        'adjective'
      end

      def column_names_and_types
        super.merge(
          {
            adjective_ru: 'VARCHAR(255)',
            adjective_en: 'VARCHAR(255)'
          }
        )
      end
    end
  end

  class Comparative < AdjectivesBase
    class << self
      def data_key
        'comparative'
      end

      def column_names_and_types
        super.merge(
          {
            comparative_ru: 'VARCHAR(255)',
            comparative_en: 'VARCHAR(255)'
          }
        )
      end
    end
  end

  class Superlative < AdjectivesBase
    class << self
      def data_key
        'superlative'
      end

      def column_names_and_types
        super.merge(
          {
            superlative_ru: 'VARCHAR(255)',
            superlative_en: 'VARCHAR(255)'
          }
        )
      end
    end
  end
end

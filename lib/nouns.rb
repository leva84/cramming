module Nouns
  class NounsBase < ModelBase
    class << self
      def table_name
        'nouns'
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

  class Noun < NounsBase
    class << self
      def data_key
        'noun'
      end

      def column_names_and_types
        super.merge(
          {
            noun_ru: 'VARCHAR(255)',
            noun_en: 'VARCHAR(255)'
          }
        )
      end
    end
  end

  class Plural < NounsBase
    class << self
      def data_key
        'plural'
      end

      def column_names_and_types
        super.merge(
          {
            plural_ru: 'VARCHAR(255)',
            plural_en: 'VARCHAR(255)'
          }
        )
      end
    end
  end
end

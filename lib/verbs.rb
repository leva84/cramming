module Verbs
  class VerbsBase < ModelBase
    class << self
      def table_name
        'verbs'
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

  class Verb < VerbsBase
    class << self
      def data_key
        'verb'
      end

      def column_names_and_types
        super.merge(
          {
            verb_ru: 'VARCHAR(255)',
            verb_en: 'VARCHAR(255)'
          }
        )
      end
    end
  end

  class SimplePast < VerbsBase
    class << self
      def data_key
        'simple_past'
      end

      def column_names_and_types
        super.merge(
          {
            simple_past_ru: 'VARCHAR(255)',
            simple_past_en: 'VARCHAR(255)'
          }
        )
      end
    end
  end

  class PastParticiple < VerbsBase
    class << self
      def data_key
        'past_participle'
      end

      def column_names_and_types
        super.merge(
          {
            past_participle_ru: 'VARCHAR(255)',
            past_participle_en: 'VARCHAR(255)'
          }
        )
      end
    end
  end
end

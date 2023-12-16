module Nouns
  class NounsBase < ModelBase
    class << self
      def table_name
        'nouns'
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
    end
  end

  class Plural < NounsBase
    class << self
      def data_key
        'plural'
      end
    end
  end
end

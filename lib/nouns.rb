module Nouns
  class NounsBase < ModelBase
    class << self
      def table_name
        'nouns'
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

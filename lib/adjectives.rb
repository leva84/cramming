module Adjectives
  class AdjectivesBase < ModelBase
    class << self
      def table_name
        'adjectives'
      end
    end
  end

  class Adjective < AdjectivesBase
    class << self
      def data_key
        'adjective'
      end
    end
  end

  class Comparative < AdjectivesBase
    class << self
      def data_key
        'comparative'
      end
    end
  end

  class Superlative < AdjectivesBase
    class << self
      def data_key
        'superlative'
      end
    end
  end
end

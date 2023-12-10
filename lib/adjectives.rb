require_relative 'model_base'

module Adjectives
  class AdjectivesBase < ModelBase
    class << self
      def data_file_path
        'data/adjectives.yml'
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

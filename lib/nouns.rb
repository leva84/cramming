require_relative 'model_base'

module Nouns
  class NounsBase < ModelBase
    class << self
      def data_file_path
        'data/nouns.yml'
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

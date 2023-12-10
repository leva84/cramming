require_relative 'model_base'

module Verbs
  class VerbsBase < ModelBase
    class << self
      def data_file_path
        'data/verbs.yml'
      end
    end
  end

  class Verb < VerbsBase
    class << self
      def data_key
        'verb'
      end
    end
  end

  class SimplePast < VerbsBase
    class << self
      def data_key
        'simple_past'
      end
    end
  end

  class PastParticiple < VerbsBase
    class << self
      def data_key
        'past_participle'
      end
    end
  end
end

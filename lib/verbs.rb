require_relative 'model_base'

module Verbs
  class VerbsBase < ModelBase
    def self.data_file_path
      'data/verbs.yml'
    end
  end

  class Verb < VerbsBase
    def self.data_key
      'verb'
    end
  end

  class SimplePast < VerbsBase
    def self.data_key
      'simple_past'
    end
  end

  class PastParticiple < VerbsBase
    def self.data_key
      'past_participle'
    end
  end
end

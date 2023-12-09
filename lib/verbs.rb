require_relative 'model_base'

module Verbs
  class Verbs < ModelBase
    def self.database_path
      'data/verbs.yml'
    end
  end

  class Verb < Verbs
    def self.model_name
      'verb'
    end
  end

  class SimplePast < Verbs
    def self.model_name
      'simple_past'
    end
  end

  class PastParticiple < Verbs
    def self.model_name
      'past_participle'
    end
  end
end

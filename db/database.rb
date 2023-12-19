class Database
  LIST_OF_MODELS = [
    Nouns::Noun,
    Nouns::Plural,
    Verbs::Verb,
    Verbs::SimplePast,
    Verbs::PastParticiple,
    Adjectives::Adjective,
    Adjectives::Comparative,
    Adjectives::Superlative
  ].freeze

  class << self
    def db
      @db = SQLite3::Database.new(Config.database_name)
    end

    def setup
      LIST_OF_MODELS.each do |model|
        model.create_table
        model.add_columns
      end

      db
    end

    def drop
      FileUtils.rm(db.filename) if File.exist?(db.filename)
    end
  end
end

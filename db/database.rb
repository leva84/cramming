require 'sqlite3'

class Database
  def self.setup
    db = SQLite3::Database.new 'cramming.db'

    db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS verbs (
        id INTEGER PRIMARY KEY,
        verb_ru TEXT,
        verb_en TEXT,
        simple_past_ru TEXT,
        simple_past_en TEXT,
        past_participle_ru TEXT,
        past_participle_en TEXT
      );
    SQL

    db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS nouns (
        id INTEGER PRIMARY KEY,
        noun_ru TEXT,
        noun_en TEXT,
        plural_ru TEXT,
        plural_en TEXT
      );
    SQL

    db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS adjectives (
        id INTEGER PRIMARY KEY,
        adjective_ru TEXT,
        adjective_en TEXT,
        comparative_ru TEXT,
        comparative_en TEXT,
        superlative_ru TEXT,
        superlative_en TEXT
      );
    SQL

    db
  end
end

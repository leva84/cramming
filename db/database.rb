require 'sqlite3'
require 'fileutils'
require_relative '../lib/model_base'

class Database
  class << self
    def db
      ENV['APP_ENV'] ||= 'development'

      @db = if ENV['APP_ENV'] == 'test'
              # Настройка для тестового окружения
              SQLite3::Database.new 'test.db'
            elsif ENV['APP_ENV'] == 'development'
              # Настройка для окружения разработки
              SQLite3::Database.new 'cramming.db'
            else
              # Настройка для продакшн окружения
              SQLite3::Database.new 'production_cramming.db'
            end
    end

    def setup
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

    def drop
      # binding.pry
      FileUtils.rm(db.filename) if File.exist?(db.filename)
    end
  end
end

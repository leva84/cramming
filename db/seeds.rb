require 'yaml'
require_relative 'database'

class Seeds
  def self.seed
    db = Database.setup

    # Чтение данных из YAML-файла
    verbs_data = YAML.load_file('data/verbs.yml')
    nouns_data = YAML.load_file('data/nouns.yml')
    adjectives_data = YAML.load_file('data/adjectives.yml')

    # Вставка данных в базу данных
    verbs_data.each do |hash|
      db.execute 'INSERT INTO verbs (verb_ru, verb_en, simple_past_ru, simple_past_en, past_participle_ru, past_participle_en) VALUES (?, ?, ?, ?, ?, ?)', [
        hash.dig('verb', 'ru'),
        hash.dig('verb', 'en'),
        hash.dig('simple_past', 'ru'),
        hash.dig('simple_past', 'en'),
        hash.dig('past_participle', 'ru'),
        hash.dig('past_participle', 'en')
      ]
    end

    nouns_data.each do |hash|
      db.execute 'INSERT INTO nouns (noun_ru, noun_en, plural_ru, plural_en) VALUES (?, ?, ?, ?)', [
        hash.dig('noun', 'ru'),
        hash.dig('noun', 'en'),
        hash.dig('plural', 'ru'),
        hash.dig('plural', 'en')
      ]
    end

    adjectives_data.each do |hash|
      db.execute 'INSERT INTO adjectives (adjective_ru, adjective_en, comparative_ru, comparative_en, superlative_ru, superlative_en) VALUES (?, ?, ?, ?, ?, ?)', [
        hash.dig('adjective', 'ru'),
        hash.dig('adjective', 'en'),
        hash.dig('comparative', 'ru'),
        hash.dig('comparative', 'en'),
        hash.dig('superlative', 'ru'),
        hash.dig('superlative', 'en')
      ]
    end
  end
end

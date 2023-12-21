class Database
  class << self
    def db
      @db = SQLite3::Database.new(Config.database_name)
    end

    def setup
      attributes_for_models.keys.each do |model|
        create_table_for_model(model)
        synchronize_model_columns(model)
      end

      db
    end

    def drop
      FileUtils.rm(db.filename) if File.exist?(db.filename)
    end

    def attributes_for_models
      @attributes_for_models ||= ModelBase.class_variable_get(:@@column_names_and_types_for_models)
    end

    def create_table_for_model(model)
      attributes_to_string = attributes_for_models[model].map { |k, v| "#{ k } #{ v }" }.join(', ')

      query = "CREATE TABLE IF NOT EXISTS #{ model.table_name } (id INTEGER PRIMARY KEY, #{ attributes_to_string });"

      db.execute(query)
    end

    def synchronize_model_columns(model)
      columns = db.execute("PRAGMA table_info(#{ model.table_name });").map { |row| row[1] }

      attributes_for_models[model].each do |k, v|
        next if columns.include?(k.to_s)

        query = "ALTER TABLE #{ model.table_name } ADD COLUMN #{ k } #{ v };"

        db.execute(query)
      end
    end
  end
end

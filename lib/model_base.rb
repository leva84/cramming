class ModelBase
  def initialize(attributes = {})
    self.class.validate_attributes(attributes)
    self.class.attr_accessor(*attributes.keys)

    attributes.each do |k, v|
      send("#{ k }=", v)
    end
  end

  def update(attributes)
    self.class.validate_attributes(attributes)

    set_clause = attributes.map { |k, _| "#{ k } = ?" }.join(', ')

    db.execute(
      "UPDATE #{ table_name } SET #{ set_clause } WHERE id = ?",
      *attributes.values,
      id
    ) == []
  end

  def delete
    db.execute(
      "DELETE FROM #{ table_name } WHERE id = ?",
      id
    ) == []
  end

  class << self
    def create_table
      attributes_string = column_names_and_types.map { |name, type| "#{ name } #{ type }" }.join(', ')

      query = "CREATE TABLE IF NOT EXISTS #{ table_name } (#{ attributes_string });"

      Database.db.execute(query)
    end

    def add_columns
      columns = Database.db.execute("PRAGMA table_info(#{ table_name });").map { |row| row[1] }

      column_names_and_types.each do |name, type|
        next if columns.include?(name.to_s)

        query = "ALTER TABLE #{ table_name } ADD COLUMN #{name} #{type};"

        Database.db.execute(query)
      end
    end

    def method_missing(name, *args, &block)
      if attributes_keys.include?(name)
        name
      else
        super
      end
    end

    def respond_to_missing?(name, include_private = false)
      attributes_keys.include?(name) || super
    end

    def validate_attributes(attributes)
      attributes.each_key do |key|
        raise ArgumentError, "Invalid attribute: #{ key } for #{ self }" unless attributes_keys.include?(key)
      end
    end

    def create(attributes)
      validate_attributes(attributes)

      columns = attributes.keys.map(&:to_s).join(', ')
      placeholders = Array.new(attributes.size, '?').join(', ')

      db.execute(
        "INSERT INTO #{ table_name } (#{ columns }) VALUES (#{ placeholders })",
        *attributes.values
      ) == []
    end

    def all
      db.execute(query_template).map do |row|
        build_instance(row)
      end
    end

    def find(id)
      row = db.get_first_row("#{ query_template } WHERE id = ?", id)

      build_instance(row) if row
    end

    def find_by(args)
      validate_attributes(args)

      query = "#{ query_template } WHERE " + args_query(args)
      row = db.get_first_row(query, *args.values)

      build_instance(row) if row
    end

    def where(args)
      validate_attributes(args)

      query = "#{ query_template } WHERE " + args_query(args)

      db.execute(query, *args.values).map do |row|
        build_instance(row)
      end
    end

    def build_instance(row)
      attributes = {}

      attributes_keys.each_with_index { |k, i| attributes[k] = row[i] }

      new(attributes)
    end

    def db
      Database.db
    end

    def attributes_keys
      @attributes_keys ||= db.execute("PRAGMA table_info(#{ table_name })").map { |row| row[1].to_sym }
    end

    def table_name
      raise NotImplementedError, "Subclasses must define a 'table_name' method."
    end

    def data_key
      raise NotImplementedError, "Subclasses must define a 'data_key' method."
    end

    def column_names_and_types
      raise NotImplementedError, "Subclasses must define a 'column_names_and_types' method."
    end

    def query_template
      @query_template ||= "SELECT #{ attributes_keys } FROM #{ table_name }"
    end

    def args_query(args)
      args.map { |k, _| "#{ k } = ?" }.join(' AND ')
    end
  end

  private

  def data_key
    self.class.data_key
  end

  def db
    self.class.db
  end

  def table_name
    self.class.table_name
  end
end

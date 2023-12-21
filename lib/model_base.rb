class ModelBase
  class_variable_set(:@@column_names_and_types_for_models, {})

  def initialize(attributes = {})
    attributes.each { |k, v| send("#{ k }=", v) }
  end

  def update(attributes)
    set_clause = attributes.map { |k, _| "#{ k } = ?" }.join(', ')

    self.class.db.execute(
      "UPDATE #{ self.class.table_name } SET #{ set_clause } WHERE id = ?",
      *attributes.values,
      id
    ) == []
  end

  def delete
    self.class.db.execute(
      "DELETE FROM #{ self.class.table_name } WHERE id = ?",
      id
    ) == []
  end

  class << self
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

    def create(attributes)
      columns = attributes.keys.map(&:to_s).join(', ')
      placeholders = Array.new(attributes.size, '?').join(', ')

      db.execute(
        "INSERT INTO #{ table_name } (#{ columns }) VALUES (#{ placeholders })",
        *attributes.values
      ) == []
    end

    def all
      db.execute(query_template).map do |row|
        build_instance(row) if row
      end
    end

    def find(id)
      row = db.get_first_row("#{ query_template } WHERE id = ?", id)

      build_instance(row) if row
    end

    def find_by(args)
      query = "#{ query_template } WHERE " + args.map { |k, _| "#{ k } = ?" }.join(' AND ')
      row = db.get_first_row(query, *args.values)

      build_instance(row) if row
    end

    def where(args)
      query = "#{ query_template } WHERE " + args.map { |k, _| "#{ k } = ?" }.join(' AND ')

      db.execute(query, *args.values).map do |row|
        build_instance(row) if row
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
      @@column_names_and_types_for_models[self].keys.unshift(:id)
    end

    def table_name
      raise NotImplementedError, "Subclasses must define a 'table_name' method."
    end

    def set_column_names_and_types_for_model(attributes)
      @@column_names_and_types_for_models[self] = attributes

      attr_accessor(*attributes_keys)
    end

    def query_template
      @query_template ||= "SELECT #{ attributes_keys.join(', ') } FROM #{ table_name }"
    end
  end
end

require 'sqlite3'

ModelBase = Struct.new(:id, :ru, :en) do
  def update(attributes)
    set_clause = attributes.map { |k, _| "#{ data_key }_#{ k } = ?" }.join(', ')

    db.execute("UPDATE #{ table_name } SET #{ set_clause } WHERE id = ?", *attributes.values, id) == []
  end

  def delete
    db.execute("DELETE FROM #{ table_name } WHERE id = ?", id) == []
  end

  class << self
    def create(attributes)
      columns = attributes.keys.map { |k| "#{ data_key }_#{ k }" }.join(', ')
      placeholders = Array.new(attributes.size, '?').join(', ')

      db.execute("INSERT INTO #{ table_name } (#{ columns }) VALUES (#{ placeholders })", *attributes.values)

      find(db.last_insert_row_id)
    end

    def all
      @all ||= db.execute(query_template).map do |row|
        build_instance(row)
      end
    end

    def find(id)
      row = db.get_first_row("#{ query_template } WHERE id = ?", id)

      build_instance(row) if row
    end

    def find_by(args)
      query = "#{ query_template } WHERE " + args_query(args)
      row = db.get_first_row(query, *args.values)

      build_instance(row) if row
    end

    def where(args)
      query = "#{ query_template } WHERE " + args_query(args)

      db.execute(query, *args.values).map do |row|
        build_instance(row)
      end
    end

    def build_instance(row)
      new(*row.to_a.map(&:to_s))
    end

    def db
      @db ||= SQLite3::Database.new 'cramming.db'
    end

    def table_name
      raise NotImplementedError, "Subclasses must define a 'table_name' method."
    end

    def data_key
      raise NotImplementedError, "Subclasses must define a 'data_key' method."
    end

    def query_template
      "SELECT id, #{ data_key }_ru, #{ data_key }_en FROM #{ table_name }"
    end

    def args_query(args)
      args.map do |k, _|
        if k == :id
          "#{ k } = ?"
        else
          "#{ data_key }_#{ k } = ?"
        end
      end.join(' AND ')
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

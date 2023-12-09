require 'yaml'

ModelBase = Struct.new(:id, :ru, :en) do
  class << self
    def all
      @all ||= database.map do |json_hash|
        build_instance(json_hash)
      end
    end

    def find(id)
      all.find { |model| model.id == id }
    end

    def find_by(args)
      all.find do |model|
        args.all? { |k, v| model.send(k) == v }
      end
    end

    def where(args)
      all.select do |model|
        args.all? { |k, v| model.send(k) == v }
      end
    end

    def build_instance(json_hash)
      new(
        json_hash['id'],
        json_hash.dig(model_name, 'ru'),
        json_hash.dig(model_name, 'en')
      )
    end

    def database
      @database ||= YAML.load_file(database_path)
    end

    def database_path
      raise NotImplementedError, "Subclasses must define a 'database_path' method."
    end

    def model_name
      raise NotImplementedError, "Subclasses must define a 'model_name' method."
    end
  end
end

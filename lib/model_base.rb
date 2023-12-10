require 'yaml'

ModelBase = Struct.new(:id, :ru, :en) do
  class << self
    def all
      @all ||= data.map do |json_hash|
        build_instance(json_hash)
      end
    end

    def find(id)
      all.find { |instance| instance.id == id }
    end

    def find_by(args)
      all.find do |instance|
        args.all? { |k, v| instance.send(k) == v }
      end
    end

    def where(args)
      all.select do |instance|
        args.all? { |k, v| instance.send(k) == v }
      end
    end

    def build_instance(json_hash)
      new(
        json_hash['id'],
        json_hash.dig(data_key, 'ru'),
        json_hash.dig(data_key, 'en')
      )
    end

    def data
      @data ||= YAML.load_file(data_file_path)
    end

    def data_file_path
      raise NotImplementedError, "Subclasses must define a 'data_file_path' method."
    end

    def data_key
      raise NotImplementedError, "Subclasses must define a 'data_key' method."
    end
  end
end

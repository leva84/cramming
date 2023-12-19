class Config
  class << self
    def database_name
      if self.app_env == 'test'
        'test.db'
      elsif self.app_env == 'development'
        'cramming.db'
      else
        'production_cramming.db'
      end
    end

    def app_env
      ENV['APP_ENV'] ||= 'development'
    end
  end
end

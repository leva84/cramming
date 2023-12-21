class Config
  class << self
    def database_name
      if app_env == 'test'
        'test.db'
      elsif app_env == 'development'
        'cramming.db'
      else
        'production_cramming.db'
      end
    end

    def app_env
      ENV.fetch('APP_ENV') { 'development' }
    end
  end
end

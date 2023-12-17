ENV['APP_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'rspec'
require 'pry'
require_relative '../lib/model_base'
require_relative '../lib/verbs'
require_relative '../lib/nouns'
require_relative '../lib/adjectives'
require_relative '../db/database'
require_relative '../db/seeds'
require_relative '../spec/support/shared_context'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    Database.drop
    Database.setup
    Seeds.seed
  end
end

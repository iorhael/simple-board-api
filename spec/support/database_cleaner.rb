RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:active_record].clean_with :truncation, except: %w[ar_internal_metadata]
    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner[:redis].strategy = :deletion
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

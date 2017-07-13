Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379' }

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
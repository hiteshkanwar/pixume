Pixsume::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  # Kailash: Enabling compression
  config.assets.compress = true

  # Expands the lines which load the assets
  # Kailash: Disabling debugging
  config.assets.debug = false

  # Kailash: Generate digests for assets URLs
  config.assets.digest = true

  # Kailash: Enable GZIP compression
  config.middleware.insert_before('ActionDispatch::Static', Rack::Deflater)
  
  config.action_mailer.default_url_options = { :host => Settings.mail_settings.host_url }

  # Google Analytics
  config.gem 'rack-google-analytics', :lib => 'rack/google-analytics'
  config.middleware.use Rack::GoogleAnalytics, :tracker => 'UA-39545351-1'
end

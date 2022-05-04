Sentry.init do |config|
  # Sentry is only enabled when the dsn is set.
  unless Rails.env.development? || Rails.env.test?
    config.dsn = 'https://0cf20ca5e6674fb8a5cf8e4620749677@sentry.shefcompsci.org.uk/102'
  end

  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.before_send = lambda { |event, _hint|
    ActiveSupport::ParameterFilter.new(Rails.application.config.filter_parameters).filter(event.to_hash)
  }
  config.excluded_exceptions += ['CanCan::AccessDenied', 'SystemExit',
                                 'ActionDispatch::Http::MimeNegotiation::InvalidType']
end

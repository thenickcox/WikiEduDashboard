require 'raven'

unless Rails.env.test?
  Raven.configure do |config|
    config.dsn = Figaro.env.sentry_dsn
    config.silence_ready = true
  end
end

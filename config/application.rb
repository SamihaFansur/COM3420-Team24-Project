require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Require gems used by epi_cas
require 'devise'
require 'devise_cas_authenticatable'
require 'devise_ldap_authenticatable'
require 'sheffield_ldap_lookup'
require 'rack-cas/session_store/active_record'

require 'csv'
module Team24
  class Application < Rails::Application
    # Send queued jobs to delayed_job
    config.active_job.queue_adapter = :delayed_job
    config.rack_cas.session_store = RackCAS::ActiveRecordStore
    config.rack_cas.server_url = 'https://login.shef.ac.uk/cas' # replace with your server URL
    config.rack_cas.service = '/users/service' # If your user model isn't called User, change this
    # This points to our own routes middleware to handle exceptions
    config.exceptions_app = routes

    I18n.enforce_available_locales = false
    config.generators do |g|
      g.orm                 :active_record
      g.template_engine     :haml
      g.fixture_replacement :factory_bot,
                            dir: 'spec/factories'
      g.test_framework      :rspec,
                            fixture: true,
                            helper_specs: true,
                            routing_specs: false,
                            controller_specs: false,
                            view_specs: false,
                            integration_tool: false
    end

    config.action_mailer.smtp_settings = {
      address: 'mailhost.shef.ac.uk',
      port: 587,
      enable_starttls_auto: true,
      openssl_verify_mode: OpenSSL::SSL::VERIFY_PEER,
      openssl_verify_depth: 3,
      ca_file: '/etc/ssl/certs/ca-certificates.crt',
      domain: 'student-app.demo.shefcompsci.org.uk'
    }

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.autoloader = :classic

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

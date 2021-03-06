require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StandupApp
  class Application < Rails::Application

config.active_job.queue_adapter = :sidekiq
config.action_cable.mount_path = '/websocket'

 config.time_zone = 'UTC'
config.active_record.default_timezone = :utc
config.active_record.time_zone_aware_types = [:datetime, :time]
    # Initialize configuration defaults for originally generated Rails version.
    #config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

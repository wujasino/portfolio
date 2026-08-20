require_relative "boot"

require "rails"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie" if defined?(Sprockets)

Bundler.require(*Rails.groups)

module PortfolioRails
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w[assets tasks])

    # Static portfolio site — no database, no Active Record.
    config.generators.skip_active_record = true
    config.api_only = false
  end
end

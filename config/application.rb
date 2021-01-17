require_relative 'boot'
require_relative '../app/middlewares/authentication_middleware'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LoginRegisterAndTodoApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # autoload paths
    config.autoload_paths << "#{Rails.root}/app/validations"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.paths << Rails.root.join("app", "assets", "stylesheets")

    # Middleware
    config.middleware.use AuthenticationMiddleware
  end
end

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rollbook
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = "Asia/Tokyo"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "*.{rb,yml}").to_s]

    # app/assets/fontsを追加する。
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.assets.precompile += %w( .svg .eot .woff .ttf )

    # StylesheetとJavaScriptをジェネレイトしない。
    config.generators.stylesheets = false
    config.generators.javascripts = false

    # Validationのエラーのとき、HTMLを変えない。
    ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    # すべてのヘルパーを読み込まない。
    #config.action_controller.include_all_helpers = false

    #config.assets.initialize_on_precompile = false
    I18n.enforce_available_locales = false

    # libを自動で読み込む。
    # config.autoload_paths += %W(#{config.root}/lib)
    config.paths.add 'lib', eager_load: true

    config.active_record.default_timezone = 'Asia/Tokyo'
  end
end

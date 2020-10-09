require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mayby
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    config.load_defaults 6.0
    config.autoloader = :classic


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # 日本語化
    config.i18n.default_locale = :ja
    # バリデーション失敗によるレイアウト崩れを防ぐ設定
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
    # DEPRECATION WARNING(カスタム親クラスは非推奨、将来削除される警告)
    ActiveSupport::Deprecation.silenced = true if Rails.version == '6.0.3'
  end
end
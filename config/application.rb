require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)


module TestTailwind
  class Application < Rails::Application
    config.load_defaults 6.1
    config.time_zone = "Asia/Tokyo"
    config.i18n.default_locale = :ja

    # エラー時「field_with_errors」が読み込まれないようにする 
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end

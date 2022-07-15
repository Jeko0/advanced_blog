require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module TestBlog
  class Application < Rails::Application

    config.load_defaults 7.0
    config.i18n.default_locale = :en 
    config.i18n.available_locales = [:en, :ka]

    
    config.generators do |g| 
      g.template_engine :erb
    end
  end
end


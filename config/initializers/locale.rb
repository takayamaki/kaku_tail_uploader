I18n.default_locale = :ja
I18n.available_locales = [:ja, :en]
Rails.application.config.time_zone = ENV.fetch('TIME_ZONE'){'Asia/Tokyo'}

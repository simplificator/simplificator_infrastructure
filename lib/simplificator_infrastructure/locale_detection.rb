module SimplificatorInfrastructure::LocaleDetection

  module InstanceMethods

    private

    def detect_locale
      locale_from_params || locale_from_header || locale_default
    end

    def locale_from_params
      locale = params['locale']
      available_locale_or_nil(locale)
    end

    def locale_from_header
      # Use "curl  -H 'Accept-language: fr' localhost:3000" to test it.

      header = request.env['HTTP_ACCEPT_LANGUAGE']
      return if header.blank?

      locale = header.scan(/^[a-z]{2}/).first
      available_locale_or_nil(locale)
    end

    def locale_default
      I18n.default_locale
    end

    def available_locale_or_nil(locale)
      I18n.available_locales.map(&:to_s).include?(locale) ? locale.to_sym : nil
    end
  end

  def self.included(receiver)
    receiver.send :include, InstanceMethods
  end
end

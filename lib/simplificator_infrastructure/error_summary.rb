class SimplificatorInfrastructure::ErrorSummary

  attr_reader :env

  def initialize(env)
    @env = env
  end

  # detects the status code based on the exception that was thrown
  def status_code
    @status_code ||= ActionDispatch::ExceptionWrapper.new(env, exception).status_code
  end

  # extracts the exception from env
  def exception
    env['action_dispatch.exception']
  end

  def params
    env['action_dispatch.request.parameters']
  end

  # tries to detect locale based on #available_locales
  # and a locale which is in the path, in params (:locale), in the accept header or default
  def locale
    path_locale || params_locale || accept_locale || default_locale
  end

  private

  def request_path
    env['REQUEST_PATH']
  end

  def default_locale
    I18n.default_locale
  end

  def params_locale
    locale = params['locale'].try(:to_sym)
    nil_if_locale_is_unknown(locale)
  end

  def path_locale
    match = request_path.try(:match, /\A\/([a-z]{2})\/.*\z/)
    locale = match[1].try(:to_sym) if match
    nil_if_locale_is_unknown(locale)
  end

  def available_locales
    I18n.available_locales
  end

  # Gets the first two letter locale from HTTP_ACCEPT_LANGUAGE header
  # (ignoring de_DE style locales and expecting locales to be ordered by quality)
  def accept_locale
    accept_header = env['HTTP_ACCEPT_LANGUAGE']
    locale = accept_header.try(:scan, /[a-z]{2}/).try(:first).try(:to_sym)
    nil_if_locale_is_unknown(locale)
  end


  def nil_if_locale_is_unknown(locale)
    available_locales.include?(locale) ? locale : nil
  end

end

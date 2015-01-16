class SimplificatorInfrastructure::ErrorSummary

  attr_reader :env

  def initialize(options = {})
    @env = options[:env]
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
  # and a locale which is in the path, in the accept header or default
  def locale
    detected_locale = path_locale || params_locale || accept_locale || default_locale
    available_locales.include?(detected_locale) ? detected_locale : default_locale
  end

  private

  def default_locale
    I18n.default_locale
  end

  def params_locale
    locale = params['locale']
    locale.to_sym if locale
  end

  def path_locale
    path = env['REQUEST_PATH']
    # RE is built on the fly to avoid load order issues with I18n.available_locales
    locales_matcher = available_locales.map(&:to_s).join('|')
    match = path.match(/\A\/(#{locales_matcher})\/.*\z/)
    match[1].to_sym if match && match[1]
  end

  def available_locales
    I18n.available_locales
  end

  # Gets the first two letter locale from HTTP_ACCEPT_LANGUAGE header
  # (ignoring de_DE style locales and expecting locales to be ordered by quality)
  def accept_locale
    accept_header = env['HTTP_ACCEPT_LANGUAGE']
    accept_header.scan(/^[a-z-]{2}/).try(:first).try(:to_sym)
  end


end

class SimplificatorInfrastructure::ErrorSummary
  include SimplificatorInfrastructure::LocaleDetection

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
    locale_from_path || locale_from_params || locale_from_header || locale_default
  end

  private

  def request
    @request ||= Rack::Request.new(env)
  end

  def request_path
    env['REQUEST_PATH']
  end

  def locale_from_path
    match = request_path.try(:match, /\A\/([a-z]{2})\/.*\z/)
    locale = match[1].try(:to_sym) if match
    available_locale_or_nil(locale)
  end

end

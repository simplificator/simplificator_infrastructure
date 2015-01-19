class SimplificatorInfrastructure::ErrorsController < ActionController::Base
  around_filter :with_locale

  layout 'simplificator_infrastructure/errors'
  helper_method :error_summary


  def render_error
    render template, status: error_summary.status_code
  end

  private

  def template
    if specific_error_template_exists?
      specific_template
    else
      generic_template
    end
  end

  def specific_template
    "errors/#{error_summary.status_code}"
  end

  def generic_template
    'errors/generic_error'
  end

  def specific_error_template_exists?
    lookup_context.template_exists?(error_summary.status_code, "errors", false)
  end

  def error_summary
    @error_summary ||= begin
      ::SimplificatorInfrastructure::ErrorSummary.new(env)
    end
  end

  # sets the locale and resets afterwards for I18n.t to work in error templates
  def with_locale
    I18n.with_locale(error_summary.locale) do
      yield
    end
  end

end

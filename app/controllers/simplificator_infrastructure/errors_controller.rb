class SimplificatorInfrastructure::ErrorsController < ActionController::Base
  around_action :with_locale

  layout 'simplificator_infrastructure/errors'
  helper_method :error_summary


  def render_error
    respond_to do |format|
      format.any do
        render template_for_status_code, status: error_summary.status_code, content_type: 'text/html'
      end
      format.json do
        render json: {message: "An error occured"}, status: error_summary.status_code
      end
    end
  end

  private

  # Returns the template for the status code that is associated to the current error.
  # INCLUDING 'html' as type to force rendering of the html view.
  def template_for_status_code
    if specific_error_template_exists?
      specific_template
    else
      generic_template
    end
  end

  def specific_template
    "errors/#{error_summary.status_code}.html"
  end

  def generic_template
    'errors/generic_error.html'
  end

  def specific_error_template_exists?
    lookup_context.template_exists?("#{error_summary.status_code}.html", "errors", false)
  end

  def error_summary
    @error_summary ||= begin
      ::SimplificatorInfrastructure::ErrorSummary.new(request.env)
    end
  end

  # sets the locale and resets afterwards for I18n.t to work in error templates
  def with_locale
    I18n.with_locale(error_summary.locale) do
      yield
    end
  end
end

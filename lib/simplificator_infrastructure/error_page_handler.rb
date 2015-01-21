class SimplificatorInfrastructure::ErrorPageHandler

  def self.register
    enable_error_page_rendering
    register_exception_app
  end

  private

  def self.enable_error_page_rendering
    # Enables rendering of error pages.
    # Those settings are usually set up properly in staging/production environments anyway.
    Rails.application.config.consider_all_requests_local = false
    Rails.application.config.action_dispatch.show_exceptions = true
  end

  def self.register_exception_app
    Rails.application.config.exceptions_app = lambda do |env|
      action = SimplificatorInfrastructure::ErrorsController.action(:render_error)
      action.call(env)
    end
  end

end

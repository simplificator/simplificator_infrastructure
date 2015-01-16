class SimplificatorInfrastructure::ErrorPageHandler

  def self.register
    disable_all_requests_local
    register_exception_app
  end

  private

  def self.disable_all_requests_local
    Rails.application.config.consider_all_requests_local = false
  end

  def self.register_exception_app
    Rails.application.config.exceptions_app= lambda do |env|
      action = SimplificatorInfrastructure::ErrorsController.action(:render_error)
      action.call(env)
    end
  end

end

module SimplificatorInfrastructure
  class Engine < ::Rails::Engine
    isolate_namespace SimplificatorInfrastructure
  end
end

require_relative 'error_summary'
require_relative 'error_page_handler'

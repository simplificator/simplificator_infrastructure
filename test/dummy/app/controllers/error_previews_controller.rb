class ErrorPreviewsController < ApplicationController
  def index
  end

  def preview
    code = (params[:code] || 500).to_i
    case code
    when 500 then raise "some generic exception"
    when 404 then raise ActionController::RoutingError.new("Was asked to raise generate a 404")
    else
      raise "Unhandled code #{code} specified: raise StandardError"
    end
  end
end

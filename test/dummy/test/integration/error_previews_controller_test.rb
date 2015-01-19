require 'test_helper'

class ErrorPreviewsControllerTest < ActionDispatch::IntegrationTest
  test '500' do
    get '/error_previews/preview'
    assert_response 500
  end

  test '404' do
    get '/error_previews/preview?code=404'
    assert_response 404
    assert_template 'errors/404'
  end


end

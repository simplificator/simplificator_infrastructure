require 'test_helper'

class ErrorPreviewsControllerTest < ActionDispatch::IntegrationTest
  test '500' do
    get '/error_previews/preview'
    assert_response 500
    assert_template 'errors/generic_error.html'
  end

  test '404' do
    get '/error_previews/preview?code=404'
    assert_response 404
    assert_template 'errors/404.html'
  end

  test 'renders html for pdf requests' do
    get '/error_previews/preview.pdf?code=404'
    assert_response 404
    assert_template 'errors/404.html'
  end


end

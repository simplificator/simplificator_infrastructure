require_relative '../../test_helper'
class SimplificatorInfrastructure::ErrorSummaryTest < ActiveSupport::TestCase
  setup do
    I18n.available_locales = [:de, :fr]
    I18n.default_locale = :de
  end

  # test 'extracts exception from env' do
  #   exception = RuntimeError.new
  #   summary = SimplificatorInfrastructure::ErrorSummary.new('action_dispatch.exception' => exception)
  #   assert_equal exception, summary.exception
  # end

  # test 'extracts params from env' do
  #   params = {a: 1, b: 2}
  #   summary = SimplificatorInfrastructure::ErrorSummary.new('action_dispatch.request.parameters' => params)
  #   assert_equal params, summary.params
  # end

  # test 'determines status_code from exception' do
  #   exception = ActionController::RoutingError.new("howdy")
  #   summary = SimplificatorInfrastructure::ErrorSummary.new('action_dispatch.exception' => exception)
  #   assert_equal 404, summary.status_code
  # end

  # test 'locale: check path' do
  #   summary = SimplificatorInfrastructure::ErrorSummary.new(
  #     'REQUEST_PATH' => '/fr/bli'
  #   )
  #   assert_equal :fr, summary.locale
  # end

  test 'locale: check params if not in path' do
    summary = SimplificatorInfrastructure::ErrorSummary.new(
      'REQUEST_PATH' => '/xx/bli',
      'action_dispatch.request.parameters' => {
        'locale' => 'fr'
      }
    )
    assert_equal :fr, summary.locale
  end

  # test 'locale: check accept header if not in path or params' do
  #   summary = SimplificatorInfrastructure::ErrorSummary.new(
  #     'REQUEST_PATH' => '/xx/bli',
  #     'action_dispatch.request.parameters' => {
  #       'locale' => 'xx',
  #     },
  #     'HTTP_ACCEPT_LANGUAGE' => 'fr-FR,fr;q=0.8,en-US;q=0.6,en;q=0.4'
  #   )
  #   assert_equal :fr, summary.locale
  # end

  # test 'locale: use default if not in path or params or accept header' do
  #   summary = SimplificatorInfrastructure::ErrorSummary.new(
  #     'REQUEST_PATH' => '/xx/bli',
  #     'action_dispatch.request.parameters' => {
  #       'locale' => 'xx',
  #     },
  #     'HTTP_ACCEPT_LANGUAGE' => 'xx-FR,fr;q=0.8,xx-US;q=0.6,xx;q=0.4'
  #   )
  #   assert_equal :de, summary.locale
  # end


end

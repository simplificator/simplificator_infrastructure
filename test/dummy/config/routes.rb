Rails.application.routes.draw do

  mount SimplificatorInfrastructure::Engine => "/simplificator_infrastructure"

  root to: 'error_previews#index'
  get 'error_previews', to: 'error_previews#index'
  get 'error_previews/preview', to: 'error_previews#preview'
end

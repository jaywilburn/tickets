require 'api_constraints'

Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'pages#main'

  get '/tickets/export', to: 'tickets#export'

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      scope module: :customers do
        resources :requested_tickets, only: [:create], param: :external_identifier
      end
      resources :tickets, only: [:index, :show, :update], param: :external_identifier
      resources :authentications, only: :create
    end
  end
end

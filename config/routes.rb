require 'api_constraints'

Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'pages#main'

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      scope module: :customers do
        resources :requested_tickets, only: [:create], param: :external_identifier
      end
      scope module: :support_agents do
        resources :assignated_tickets, only: [:update], param: :external_identifier
      end
      resources :tickets, only: [:index, :show], param: :external_identifier
      resources :authentications, only: :create
    end
  end
end

# frozen_string_literal: true

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  scope 'api/v1', defaults: { format: :json } do
    devise_for(
      :users,
      module: :devise,
      controllers: {
        sessions: 'api/v1/sessions', only: :create,
        registrations: 'api/v1/registrations'
      }
    )
  end

  namespace :api do
    namespace :v1 do # rubocop:disable Naming/VariableNumber
      post '/graphql', to: 'graphql#execute'
    end
  end
end

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations" }
  root to: 'books#index'
  resources :books
  resources :users, only: %i[index show] do
    get '/following', to: 'users/relationships#index'
  end
  resources :relationships, only: %i[create destroy], as: 'user_relationships', module: 'users'
end

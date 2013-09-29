Crowdvocate::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  ActiveAdmin.routes(self)
  match "/admin" => "admin/dashboard#index", via: :get

  get "pages/home"
  resources :projects do
    resources :events do
      resources :comments, only: [:create]
    end
    resources :pledges, only: [:create, :update]
    resources :videos do
      resources :votes, only: [:create, :destroy]
    end
  end

  root :to => "pages#home"
end

Crowdvocate::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  ActiveAdmin.routes(self)
  match "/admin" => "admin/dashboard#index", via: :get

  get "pages/home"
  resources :projects

  root :to => "pages#home"
end

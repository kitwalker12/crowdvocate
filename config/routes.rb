Crowdvocate::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root :to => "pages#home"
  get "pages/home"
  match "/admin" => "admin/dashboard#index", via: :get
end

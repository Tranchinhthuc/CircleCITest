Rails.application.routes.draw do
  resources :articles
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :users

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations', sessions: "users/sessions"}

  devise_scope :user do
    authenticated :user do
      root "offices#index", as: :authenticated_root
    end
    unauthenticated do
      root "offices#index", as: :unauthenticated_root
    end
  end

  resources :point_recharging, only: [:new, :create]

  resources :offices do
    resources :registrations
    resources :comments
  end

  resources :chat_rooms
  resources :messages


  root 'static_pages#home'
  get '/baokim_ed2f2d19466b8542.html' => 'static_pages#baokim'
  get '/nganluong_5f7805dbf7c25c1d449f32552ec4a8bb.html' => 'static_pages#nganluong'

  get "/get_districts_by_city/:id" => "static_pages#get_districts_by_city"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

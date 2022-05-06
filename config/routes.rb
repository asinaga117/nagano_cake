Rails.application.routes.draw do
  namespace :admin do
    get 'orders/index'
    get 'orders/show'
  end
  namespace :admin do
    get 'oders/index'
    get 'oders/show'
  end
  #管理者用
  devise_for :admins,skip: [:resistrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: 'homes#top'
  get 'homes/about' => 'homes#about',as: 'about'

  namespace :admin do
  resources :genres, only: [:index, :create, :edit, :update]

  resources :items, only: [:index, :new, :create, :show, :edit, :update]
  
  resources :customers, only: [:index,:show,:edit, :update]
  
   resources :orders, only: [:index,:show]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

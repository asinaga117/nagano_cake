Rails.application.routes.draw do
  #管理者用
  devise_for :admins,skip: [:resistrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  #顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    resistrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: 'homes#top'
  get 'homes/about' => 'homes#about',as: 'about'

  namespace :admin do
  resources :genres, only: [:index, :create, :edit, :update]

  resources :items, only: [:index, :new, :create, :show, :edit, :update]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

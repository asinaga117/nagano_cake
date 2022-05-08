Rails.application.routes.draw do
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]

    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  
    resources :customers, only: [:index,:show,:edit, :update]
    
    resources :orders, only: [:index,:show]
  end
  
  namespace :public do
    get "customers/quite" => 'customers#quite', as: 'quite_customer'
    #論理削除
    patch '/customers/:id/out' => 'customers#out', as: 'out'
    
    resource :customers, only: [:show,:edit, :update]  
    

    resources :addresses, only: [:index,:edit, ] 
    
    resources :orders, only: [:index,:show, :new, :confirm, :complete]
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

  get 'homes/about' => 'homes#about',as: 'about'
  root to: 'homes#top'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

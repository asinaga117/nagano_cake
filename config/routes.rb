Rails.application.routes.draw do

root 'public/homes#top'

  namespace :admin do

    get 'top' => 'homes#top'

    get 'about' => 'homes#about'


    resources :genres, only: [:index, :create, :edit, :update]

    resources :items, only: [:index, :new, :create, :show, :edit, :update]

    resources :customers, only: [:index,:show,:edit, :update]

    resources :orders, only: [:index,:show]
  end

  namespace :public do

    get 'top' => 'homes#top'

    get 'about' => 'homes#about'


    get "customers/quite" => 'customers#quite', as: 'quite_customer'
    #論理削除
    patch '/customers/:id/out' => 'customers#out', as: 'out'

    resource :customers, only: [:show,:edit, :update]


    resources :addresses, only: [:index,:edit, :create, :update, :destroy ]

    post 'orders/confirm' => 'orders#confirm'
    
    get 'orders/complete' => 'orders#complete'
    
    resources :orders, only: [:index,:show, :new, :create ]
    

    resources :items, only: [:index,:show]

    delete 'cart_items/alldestroy' => 'cart_items#destroy_all'

    resources :cart_items, only: [:index, :update, :create, :destroy]

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




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  get 'search/index'
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :posts do 
      resources :comments
      resources :likes
    end
    
    resources :charges, only: [:new, :create]
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: "users/registrations"
    }

    devise_scope :user do  
      get '/users/sign_out' => 'devise/sessions#destroy'     
    end
    
    root "home#index"

    #profile route
    get "/user_profile/:id", to: "home#profile", as: "user_profile"

    #phoning routes
    get "/user_profile/:id/add_phone", to: "phones#new", as: "add_phone"
    post "/user_profile/:id/add_phone", to: "phones#create"

    #search route
    get "search", to: "search#index"
    end
end

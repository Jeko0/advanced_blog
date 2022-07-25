Rails.application.routes.draw do
  require 'sidekiq/web'
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :posts do 
      resources :comments
      resources :likes
    end

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

    #admin route
    authenticated :user, -> (user) {user.admin?} do 
      get 'admin', to: "admin#index"
      get 'admin/posts', to: "admin#posts"
      get 'admin/users', to: "admin#users"
      get 'admin/show_post/:id', to: "admin#show_post", as: "admin_post"
      post "admin/posts/post/:id/approve", to: "admin#approve_post", as: "approve_post"
      delete "admin/posts/:id/delete", to: "admin#post_delete", as: "admin_delete_post"
      delete "admin/users/:id/delete", to: "admin#user_delete", as: "admin_delete_user"
    end

    #Stripe routes 
    get "users/:user_id/charges/new", to: "charges#new", as: :new_charges
    post "users/:user_id/charges/create", to: "charges#create", as: :charges

    #google maps 
    get "/users/:user_id/locations/all", to: "locations#index", as: :locations
    get "/users/locations/show/:id", to: "locations#show", as: :show_location
    get "users/locations/add", to: "locations#new", as: :add_location
    post "users/locations/add", to: "locations#create", as: :create_location
    delete "users/:user_id/locations/delete/:id", to: "locations#destroy", as: :destroy_address
  end
end

Rails.application.routes.draw do
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

    #admin route
    authenticated :user, -> (user) {user.admin?} do 
      get 'admin', to: "admin#index"
      get 'admin/posts', to: "admin#posts"
      get 'admin/users', to: "admin#users"
      get 'admin/show_post/:id', to: "admin#show_post", as: "admin_post"
      delete "admin/posts/:id/delete", to: "admin#delete", as: "admin_delete_post"
    end

    #approving routes
    get "/posts/:id/unapprove_posts", to: "admin#unapproved_posts", as: :unapproved_posts
    post "/posts/:id/approved_posts", to: "admin#approve_post", as: :approve_post
  end
end

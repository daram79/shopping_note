Rails.application.routes.draw do
  
  resources :settings do
    collection do
      get "edit_profile_photo"
    end
  end
  
  resources :member_notes do
    member do
      get "likes"
    end
  end
  
  resources :friends do
    member do
      post "add"
    end
  end

  resources :profile_photos
  
  resources :searches do
    collection do
      get "tag_search"
      get "user_search"
    end
  end
  
  resources :populars
  
  resources :feeds do
    collection do
      post  "create_content"
      get   "index_json"
      get   "search_tag"
      get   "newest"
    end
    member do
      post "add_like"
      post "add_comment"
      get "comment"
    end
    
  end

  devise_for :users, :controllers => {
    :sessions      => "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  
  devise_scope :user do
    get 'users/:id/info', :to => "users/sessions#info"
  end
  
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post 'registrations' => 'registrations#create', :as => 'register'
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
        post 'facebookLogin' => 'facebook#login', :as => 'fb_login'
        post 'facebook' => 'facebook#create', :as => 'fb_create'
      end
    end
  end
  
  root 'feeds#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

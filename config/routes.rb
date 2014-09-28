SampleApp::Application.routes.draw do
  #NB, was generated indirectly on p.212. On p.214, we (still) leave it in here:
  #('later' - p279 - we'll clean it up)
  #get "users/new"    #Removed p279.

  #added p279:
  resources :users do
    member do # p506 added.
      get :following, :followers
    end
  end # p506 end.

  # p328 added:
  resources :sessions, only: [:new, :create, :destroy]

  # p455 added:
  resources :microposts, only: [:create, :destroy]

  # p512 added:
  resources :relationships, only: [:create, :destroy]

  # JG NB, wonder, p202 - why not match-switch for _home_?
  # ANSWER: page 203 - it's because HOME has its own special/'official' solution - see 'root' below.
  #get "static_pages/home"  

  #p.214, custom signup route (not default name '/users/new')
  match '/signup',  to: 'users#new',            via: 'get'

  #get "static_pages/help" #Removed p202
  match '/help',    to: 'static_pages#help',    via: 'get' #added p202

  #get "static_pages/about" #Removed p202
  match '/about',   to: 'static_pages#about',   via: :get #added p202

  #get "static_pages/contact"   # added p199, removed p202
  match '/contact', to: 'static_pages#contact', via: [:get,:post] #added p202

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root 'static_pages#home'
  # this longer, and the shorter form, seem to have same effect:
  # root to: 'static_pages#home'

  # p328, added:
  match '/signin', to: 'sessions#new',      via: :get                    
  match '/signout', to: 'sessions#destroy', via: :delete  

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

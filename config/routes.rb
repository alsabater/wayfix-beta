Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: "registrations"}
  scope "/admin" do
    resources :users
  end

  devise_for :admins

  root "home#index"

  resources :clients
  resources :centers
  resources :patients

  get '/events/month', to: 'events#month', as: :events_month
  get '/events/activity_panel', to: 'events#activity_panel', as: :events_activity_panel
  get '/events/day', to: 'events#day', as: :events_day
  post 'events/day_filter', to: 'events#day_filter'
  post 'events/activity_panel_filter', to: 'events#activity_panel_filter'
  post 'events/month_filter', to: 'events#month_filter'
  put '/events/:id', to: 'events#update'
 
  resources :events

  delete '/centers_users', to: 'centers_users#destroy', as: :destroy_center_user
  
  get '/dashboard', to: 'dashboard#index'

  get '/settings', to: 'settings#index'
  get '/settings/invite_user', to: 'settings#invite_user'
  post '/settings/create_user', to: 'settings#create_user'
  post '/settings/add_personnel_to_center', to: 'settings#add_personnel_to_center'

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

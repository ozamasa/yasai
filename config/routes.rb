Rails.application.routes.draw do
  resources :portal

  resources :events

  resources :users

  resources :categories

  resources :cultivars

  resources :schedules
  get '/myschedule/:year/:month/:day/:user' => 'schedules#my_index'
  get '/schedules/:year/:month/:day/:store' => 'schedules#index'
  get '/schedules/show/:year/:month/:day/:store' => 'schedules#show'

  get '/schedules/:year/:month/:day' => 'schedules#index'
  get '/schedules/:year/:month/:day/:user' => 'schedules#my_index'
  get '/schedules/:year/:month/:day/:user/new' => 'schedules#new'

  resources :tours
  get 'tours/:tour/seluser' => 'tours#seluser'

  resources :items
  get 'shopping/:tour/:participant' => 'items#shopping_index'
  get 'items/:id/putin/:tour(/:participant)' => 'items#putin'

  resources :baskets, only: [:index, :show, :destroy]
  get 'baskets/:tour/:participant' => 'baskets#index'
  get 'baskets/:tour/order/:participant' => 'baskets#order'

  resources :orders
  get 'orders/:id/complete' => 'orders#complete'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'portal#index'

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

Rails.application.routes.draw do
  resources :events
  resources :households do
    get 'route_rsvp' => 'households#route_rsvp', on: :collection
    get 'check_names/:unique_hex' => 'households#check_names', on: :member, as: 'check_names'
    post 'update_names' => 'households#update_names', on: :member
    get 'rsvp_form/:unique_hex' => 'households#rsvp_form', on: :member, as: 'rsvp_form'
    post 'rsvp' => 'households#rsvp_submission', on: :member
    get 'rsvp/:unique_hex' => 'households#rsvp_status', on: :member, as: 'rsvp_status'
    get 'printable_rsvp/:unique_hex' => 'households#printable_rsvp_status', on: :member, as: 'printable_rsvp_status'
    delete 'logout' => 'households#logout', on: :member
  end
  resources :rsvps do
    post 'household' => 'rsvps#household_submission', on: :collection
  end
  resources :guests
  root 'pages#home'
  get '/hotel-info' => 'pages#hotel_info'
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

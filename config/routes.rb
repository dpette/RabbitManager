Rails.application.routes.draw do
  resources :race_cages
  resources :motherhood_cages do
    resources :mother_rabbits, only: [:new, :index]
  end
  resources :weaning_cages
  resources :cages do
    resources :mother_rabbits, only: [:new, :index]
  end
  resources :fattening_cages
  resources :compartments
  resources :farms
  resources :weights
  resources :pregnancies
  resources :rabbits do
    resources :weights, only: [:new, :index]
    resources :pregnancies, only: [:new, :index]
    member do
      put :kill
      get :new_birth
      post :birth
      get :new_conception
      post :conception
      get :edit_notes
      get :available_cages
      put :move
    end
  end
  resources :mother_rabbits
  resources :baby_rabbits
  resources :race_rabbits
  resources :weaning_rabbits
  resources :rabbits
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'cages#index'

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

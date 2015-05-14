Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # map.check_email "users/check_email", :controller => "users", :action => "check_email"
  # You can have the root of your site routed with "root"
  root 'site#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  post 'twilio/send_text_message' => 'twilio#send_text_message'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):

    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'

    delete 'logout' => 'sessions#destroy'
    get 'logout' => 'sessions#destroy'

    get 'classgroups/:id/students' => 'classgroups#students_add'
    post 'classgroups/:id/students' => 'classgroups#students_create'
    patch 'classgroups/:id/students' => 'classgroups#students_update'

    get 'auth/logout' => 'auth#logout'
    get 'auth/failure' => 'auth#failure'
    get 'auth/:provider/callback' => 'auth#callback'

    resources :users
    resources :classgroups do
      resources :events, :only => [:new,:create]
    end
    resources :events do
      get :get_events, on: :collection
      resources :attendances
    end
    resources :students
    # resources :attendances
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
  get "/404", :to => "errors#not_found"
  get "/422", :to => "errors#unacceptable"
  get "/500", :to => "errors#internal_error"

end

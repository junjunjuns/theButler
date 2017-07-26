Rails.application.routes.draw do

  resources :profiles do
    resources :expenses
  end
  
  get '/profiles/:profile_id/expenses_overview' => 'expenses#overview', :as => 'expenses_overview'
  
  resources :profiles do
    resources :categories do
      resources :items
    end
  end

  resources :groups do
    resources :activities do
      resources :schedules
    end
  end

  resources :groups do
    resources :messages
  end

  resources :groups do
    resources :memberships
  end
  
  get 'yourgroups' => 'groups#home', :as => 'group_home'
  get '/grouplist' => 'groups#search', :as => 'group_search'

  post '/groups/:group_id/join' => 'memberships#join', :as => 'join_membership'
  post '/groups/:group_id/memberships/:id/accept' => 'memberships#accept', :as => 'accept_membership'
  post '/groups/:group_id/memberships/:id/admin' => 'memberships#admin', :as => 'membership_admin'
  delete '/groups/:group_id/memberships/:id/leave' => 'memberships#leave', :as => 'membership_leave'


  resources :profiles
  
  get '/signedinuserprofile' => 'profiles#signedinuserprofile'

  devise_for :users
  get 'welcome/index'
  
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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

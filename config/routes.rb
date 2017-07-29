Rails.application.routes.draw do

  resources :groups do
    resources :gexpenses do
      resources :member_expenses
    end
    resources :gcategories do
      resources :gitems
    end
    resources :activities do
      resources :schedules
    end
    resources :messages
    resources :memberships
  end
  
  post '/groups/:group_id/gexpenses/:gexpense_id/member_expenses/:id/pay' => 'member_expenses#pay', :as => 'pay_gexpenses'
  post '/groups/:group_id/gexpenses/:id/calc_shared' => 'gexpenses#calc_shared', :as => 'calc_shared'


  resources :profiles do
    resources :expenses
    resources :categories do
      resources :items
    end
  end
  
  get '/profiles/:profile_id/expenses_overview' => 'expenses#overview', :as => 'expenses_overview'

  get 'yourgroups' => 'groups#home', :as => 'group_home'
  get '/grouplist' => 'groups#search', :as => 'group_search'

  post '/groups/:group_id/join' => 'memberships#join', :as => 'join_membership'
  post '/groups/:group_id/memberships/:id/accept' => 'memberships#accept', :as => 'accept_membership'
  post '/groups/:group_id/memberships/:id/admin' => 'memberships#admin', :as => 'membership_admin'
  delete '/groups/:group_id/memberships/:id/leave' => 'memberships#leave', :as => 'membership_leave'

  get '/signedinuserprofile' => 'profiles#signedinuserprofile'

  devise_for :users
  get 'welcome/index'
  
  get '/restricted' => 'welcome#restricted', :as => 'restricted'

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

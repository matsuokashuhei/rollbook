Rollbook::Application.routes.draw do

  resources :bank_accounts

  #resources :rolls

  resources :lessons do
    resources :rolls, only: :index
  end
  match "lessons/:lesson_id/rolls/edit" => "rolls#edit", via: :get, as: "edit_lesson_rolls"
  match "lessons/:lesson_id/rolls" => "rolls#update", via: :put
  match "lessons/:lesson_id/rolls/absence" => "rolls#absence", via: :get, as: "edit_absence_rolls"
  match "lessons/:lesson_id/rolls/substitute" => "rolls#substitute", via: :post

  match "members/:member_id/members_course/:id/rolls" => "rolls#index_of_members_course", via: :get, as: "members_course_rolls"
  match "members/:member_id/bank_account" => "bank_account#members_bank_account", via: :get, as: "members_bank_account"

  #match "rolls" => "rolls#index", via: :get
  #match "rolls/substitute" => "rolls#substitute", via: :post

  resources :members do
    resources :members_courses
  end

  resources :courses

  resources :age_groups

  resources :levels

  resources :dance_styles

  resources :instructors
  match "instructors/:id/courses" => "courses#instructors_courses", via: :get, as: "instructors_courses"

  resources :timetables

  resources :time_slots

  #resources :studios

  resources :schools do
    resources :studios
  end
  #match "schools/:school_id/studios" => "studios#index", via: :get, as: "studios"
  #match "schools/:school_id/studios/:id" => "studios#show", via: :get, as: "studio"
  #match "schools/:school_id/studios/new" => "studios#new", via: :get, as: "new_studio"
  #match "schools/:school_id/studios/:id/edit" => "studios#edit", via: :get, as: "edit_studio"
  #match "schools/:school_id/studios/" => "studios#create", via: :post
  #match "schools/:school_id/studios/:id" => "studios#update", via: :put
  #match "schools/:school_id/studios/:id" => "studios#show", via: :get, as: "show_studio"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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

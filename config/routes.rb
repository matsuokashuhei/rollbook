Rollbook::Application.routes.draw do

  resources :bank_accounts
  match "bank_accounts/:id/members" => "bank_accounts#members", via: :get, as: "bank_account_members"
  match "bank_accounts/:id/members/new" => "bank_accounts#new_member", via: :get, as: "new_bank_account_member"
  match "bank_accounts/:id/members" => "bank_accounts#create_member", via: :post
  match "bank_accounts/:id/members/:member_id" => "bank_accounts#destroy_member", via: :delete, as: "destroy_bank_account_member"

  resources :lessons do
    resources :rolls, only: :index
  end
  match "lessons/:lesson_id/rolls/edit" => "rolls#edit", via: :get, as: "edit_lesson_rolls"
  match "lessons/:lesson_id/rolls" => "rolls#create_or_update", via: :post
  match "lessons/:lesson_id/rolls/new" => "rolls#new", via: :get, as: "new_lesson_rolls"
  match "lessons/:lesson_id/rolls/new" => "rolls#create", via: :post

  resources :members do
    resources :members_courses, as: :courses, path: :courses do
      resources :recesses
    end
  end
  match "members/:id/rolls" => "members#rolls", via: :get, as: "member_rolls"
  match "members/:member_id/courses/:id/rolls" => "members_courses#rolls", via: :get, as: "member_course_rolls"
  match "members/:id/bank_account" => "members#bank_account", via: :get, as: "member_bank_account"

  resources :courses
  match "courses/:id/members" => "courses#members", via: :get, as: "course_members"
  match "courses/:id/lessons" => "courses#lessons", via: :get, as: "course_lessons"

  resources :instructors
  match "instructors/:id/courses" => "instructors#courses", via: :get, as: "instructor_courses"

  #resources :schools do
  #  resources :studios
  #end
  #resources :timetables
  #resources :time_slots
  #resources :age_groups
  #resources :levels
  #resources :dance_styles


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

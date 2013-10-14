Rollbook::Application.routes.draw do

  # 会員
  resources :members do
    resources :members_courses, as: :courses, path: :courses do
      resources :recesses
    end
  end
  match "members/:id/rolls" => "members#rolls", via: :get, as: "member_rolls"
  match "members/:member_id/courses/:id/rolls" => "members_courses#rolls", via: :get, as: "member_course_rolls"
  match "members/:id/bank_account" => "members#bank_account", via: :get, as: "member_bank_account"
  match "members/:id/receipts" => "members#receipts", via: :get, as: "member_receipts"

  # 口座
  resources :bank_accounts
  match "bank_accounts/:id/members" => "bank_accounts#members", via: :get, as: "bank_account_members"
  match "bank_accounts/:id/members/new" => "bank_accounts#new_member", via: :get, as: "new_bank_account_member"
  match "bank_accounts/:id/members" => "bank_accounts#create_member", via: :post
  match "bank_accounts/:id/members/:member_id" => "bank_accounts#destroy_member", via: :delete, as: "destroy_bank_account_member"

  # レッスン
  resources :lessons do
    resources :rolls, only: :index
  end
  match "lessons/:lesson_id/rolls/edit" => "rolls#edit", via: :get, as: "edit_lesson_rolls"
  match "lessons/:lesson_id/rolls" => "rolls#create_or_update", via: :post
  match "lessons/:lesson_id/absences" => "rolls#absences", via: :get, as: "absences"
  match "lessons/:lesson_id/substitutes" => "rolls#substitute", via: :post
  match "lessons/:lesson_id/nonmembers" => "rolls#nonmembers", via: :get, as: "nonmembers"
  match "lessons/:lesson_id/trials" => "rolls#trial", via: :post

  # クラス
  resources :courses
  match "courses/:id/members" => "courses#members", via: :get, as: "course_members"
  match "courses/:id/lessons" => "courses#lessons", via: :get, as: "course_lessons"

  # インストラクター
  resources :instructors
  match "instructors/:id/courses" => "instructors#courses", via: :get, as: "instructor_courses"

  # 入金
  resources :tuitions do
    resources :debits, only: [:index]
    resources :receipts
  end
  match "tuitions/:tuition_id/debits/edit" => "debits#bulk_edit", via: :get, as: "edit_tuition_debits"
  match "tuitions/:tuition_id/debits" => "debits#bulk_update", via: :patch

  match "tasks/debits" => "tasks#debits", via: :get, as: "task_debits"
  match "tasks/debits/new" => "tasks#new_debit", via: :get, as: "new_task_debit"
  match "tasks/debits/:id" => "tasks#debit", via: :get, as: "task_debit"
  match "tasks/debits" => "tasks#create_debit", via: :post
  match "tasks/debits/:id" => "tasks#update_debit", via: :patch
  match "debits/:month" => "debits#index", via: :get, as: "debits"
  match "debits/:month/edit" => "debits#bulk_edit", via: :get, as: "edit_debits"
  match "debits/:month" => "debits#bulk_update", via: :patch
  match "debits/:month/fix" => "debits#fix", via: :post, as: "fix_debits"

  #resources :tasks
  #resources :receipts
  #resources :debits
  #match "debits/tasks" => "debits#tasks_index", via: :get, as: "debit_tasks"
  #match "debits/tasks/new" => "debits#new_task", via: :get, as: "new_debit_task"
  #match "debits/tasks" => "debits#create_task", via: :post, as: "create_debit_task"
  #match "debits/tasks/:task_id" => "debits#show_task", via: :get, as: "debit_task"
  #match "debits/tasks/:task_id/edit" => "debits#edit_task", via: :get, as: "edit_debit_task"
  #match "debits/tasks/:task_id" => "debits#update_task", via: :patch, as: "update_debit_task"
  #match "debits/tasks/:task_id" => "debits#destroy_task", via: :delete

  resources :receipts

  #match "debits/:month" => "debits#bulk_show", via: :get, as: "debits"
  #match "debits/:month/edit" => "debits#bulk_edit", via: :get, as: "edit_debits"
  #match "debits/:month" => "debits#bulk_update", via: :post


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

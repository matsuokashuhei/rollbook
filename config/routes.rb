Rollbook::Application.routes.draw do

  # ユーザー
  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
      only: [:create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
      end
  end
  scope "/admin" do
    resources :users
  end

  # 会員
  resources :members do
    resources :members_courses, as: :courses, path: :courses do
    end
    resources :recesses
  end
  match "members/:id/rolls" => "members#rolls", via: :get, as: "member_rolls"
  match "members/:member_id/courses/:id/rolls" => "members_courses#rolls", via: :get, as: "member_course_rolls"
  #match "members/:id/recesses" => "members#recesses", via: :get, as: "member_recesses"
  #match "members/:id/bank_account" => "members#bank_account", via: :get, as: "member_bank_account"
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
  match "lessons/:id/fix" => "lessons#fix", via: :post, as: "fix_lesson"

  match "lessons/:lesson_id/rolls/edit" => "rolls#edit", via: :get, as: "edit_lesson_rolls"
  match "lessons/:lesson_id/rolls" => "rolls#create_or_update", via: :post
  match "lessons/:lesson_id/absences" => "rolls#absences", via: :get, as: "absences"
  match "lessons/:lesson_id/substitutes" => "rolls#substitute", via: :post
  match "lessons/:lesson_id/nonmembers" => "rolls#nonmembers", via: :get, as: "nonmembers"
  match "lessons/:lesson_id/trials" => "rolls#trial", via: :post

  # クラス
  resources :courses
  match "schools" => "courses#schools", via: :get, as: "schools"
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
  match "tuitions/:id/fix" => "tuitions#fix", via: :post, as: "fix_tuition"
  match "tuitions/:tuition_id/debits/edit" => "debits#bulk_edit", via: :post, as: "edit_tuition_debits"
  match "tuitions/:tuition_id/debits" => "debits#bulk_update", via: :patch
  match "receipts" => "tuitions#receipts", via: :get, as: "receipts"
  match "tuitions/:tuition_id/receipts/new" => "receipts#bulk_new", via: :get, as: "new_tuition_receipts"

  #resources :schools do
  #  resources :studios
  #end
  #resources :timetables
  #resources :time_slots
  #resources :age_groups
  #resources :levels
  #resources :dance_styles

  # ログ
  resources :access_logs, only: [:index]
  get "statistics/data"

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

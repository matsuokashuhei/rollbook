# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  # お知らせ
  resources :posts do
    resources :comments
  end

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
    resources :rolls, only: :index, controller: :members, action: :rolls
    resources :members_courses
    resources :recesses
  end
  match "members/:member_id/courses/:id/rolls" => "members_courses#rolls", via: :get, as: "member_course_rolls"
  match "members/:member_id/members_courses/new/timetables" => "members_courses#timetables", via: :get, as: "timetables"

  # 口座
  resources :bank_accounts
  match "bank_accounts/:id/members" => "bank_accounts#members", via: :get, as: "bank_account_members"
  match "bank_accounts/:id/members/new" => "bank_accounts#new_member", via: :get, as: "new_bank_account_member"
  match "bank_accounts/:id/members" => "bank_accounts#create_member", via: :post
  match "bank_accounts/:id/members/:member_id" => "bank_accounts#destroy_member", via: :delete, as: "destroy_bank_account_member"

  # レッスン
  resources :lessons do
    member do
      post 'fix'
      post 'unfix'
      post 'cancel'
    end
    resources :rolls, only: :index
  end

  match "lessons/:lesson_id/rolls/new" => "rolls#new", via: :get, as: "new_lesson_roll"
  match "lessons/:lesson_id/rolls/edit" => "rolls#edit", via: :get, as: "edit_lesson_rolls"
  match "lessons/:lesson_id/rolls" => "rolls#create_or_update", via: :post
  #match "lessons/:lesson_id/absentees" => "rolls#absentees", via: :get, as: "absentees"
  match "lessons/:lesson_id/rolls/:id" => "rolls#show", via: :get, as: "lesson_roll"
  match "lessons/:lesson_id/substitutes" => "rolls#substitute", via: :post

  match "absentees" => "absentees#index", via: :get, as: "absentees"
  match "absentees/:member_id" => "absentees#show", via: :get, as: "absentee"

  # クラス
  resources :courses
  match "courses/:id/members" => "courses#members", via: :get, as: "course_members"
  match "courses/:id/lessons" => "courses#lessons", via: :get, as: "course_lessons"

  # インストラクター
  resources :instructors do
    resources :courses, only: :index, controller: :instructors, action: :courses
  end

  # インストラクターの給料
  last_month = (Date.today - 1.month).strftime('%Y%m')
  match 'salaries(/)' => redirect("/salaries/#{last_month}/instructors"), via: :get
  match 'salaries/instructors(/)' => redirect("/salaries/#{last_month}/instructors"), via: :get
  match 'salaries/:month/instructors' => 'salaries#index', defaults: { month: last_month, }, via: :get, as: 'salaries'
  match 'salaries/:month/instructors/:instructor_id' => 'salaries#show', defaults: { month: last_month, }, via: :get, as: 'salary'


  # ログ
  resources :access_logs, only: [:index]

  # 統計
  match "dashboards" => "dashboards#index", via: :get, as: "dashboards"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
    end
  end
end

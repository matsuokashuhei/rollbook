crumb :root do
  link fa_icon('home lg'), root_path
end

# 会員
crumb :members do
  link t("activerecord.models.member"), members_path
end
crumb :member do |member|
  link "#{member.last_name}#{member.first_name}", member_path(member)
  parent :members
end
crumb :new_member do
  link t("views.buttons.new"), new_member_path
  parent :members
end
crumb :edit_member do |member|
  link t("views.buttons.edit"), member_path(member)
  parent :member, member
end

# 名義人
crumb :bank_accounts do
  link t("activerecord.models.bank_account"), bank_accounts_path
end
crumb :bank_account do |bank_account|
  link bank_account.holder_name, bank_account_path(bank_account)
  parent :bank_accounts
end
crumb :new_bank_account do
  link t("views.buttons.new"), new_bank_account_path
  parent :bank_accounts
end
crumb :edit_bank_account do |bank_account|
  link t("views.buttons.edit"), bank_account_path(bank_account)
  parent :bank_account, bank_account
end

# インストラクター
crumb :instructors do
  link t("activerecord.models.instructor"), instructors_path
end
crumb :instructor do |instructor|
  link instructor.name, instructor_path(instructor)
  parent :instructors
end
crumb :new_instructor do |instructor|
  link t("views.buttons.new"), new_instructor_path
  parent :instructors
end
crumb :edit_instructor do |instructor|
  link t("views.buttons.edit"), instructor_path(instructor)
  parent :instructor, instructor
end

# レッスン
crumb :lessons do
  link t("activerecord.models.lesson"), lessons_path
end
crumb :lessons_for_month do |month|
  link "#{month[0..3]}年#{month[4..5]}月", lessons_path(month: month)
  parent :lessons
end
crumb :lessons_for_day do |date|
  link "#{date.strftime('%d')}日 (#{I18n.t('date.abbr_day_names')[date.wday]})", lessons_path(date: date.to_s(:number))
  parent :lessons_for_month, date.strftime('%Y%m')
end
crumb :lesson do |lesson|
  course = lesson.course
  link "#{course.dance_style.name}#{course.level.name} #{course.instructor.name}", lesson_rolls_path(lesson)
  parent :lessons_for_day, lesson.date
end
crumb :edit_lesson do |lesson|
  link t("views.buttons.edit"), edit_lesson_rolls_path(lesson)
  parent :lesson, lesson
end
crumb :absentees do |lesson|
  link t('views.buttons.substitute'), absentees_path(lesson)
  parent :lesson, lesson
end

# クラス
crumb :courses do |date, studio|
  link studio.name, courses_path(date: date.to_s(:number), studio_id: studio.id)
end
crumb :course do |course|
  link "#{course.dance_style.name}#{course.level.name} #{course.instructor.name}", course_path(course)
  parent :courses, Date.today, course.timetable.studio
end
crumb :edit_course do |course|
  link t("views.buttons.edit"), edit_course_path(course)
  parent :course, course
end
crumb :new_course do |timetable|
  link t("views.buttons.new"), new_course_path(timetable.id)
  parent :courses, Date.today, timetable.studio
end

# ユーザー
crumb :users do
  link t("activerecord.models.user"), users_path
end
crumb :user do |user|
  link user.name, user_path(user)
  parent :users
end
crumb :edit_user do |user|
  link t("views.buttons.edit"), edit_user_path(user)
  parent :user, user
end
crumb :new_user do
  link t("views.buttons.new"), new_user_path
  parent :users
end

# お知らせ
crumb :posts do
  link t("activerecord.models.post"), posts_path
end
crumb :post do |post|
  link post.title, post_path(post)
  parent :posts
end
crumb :edit_post do |post|
  link t("views.buttons.edit"), edit_post_path(post)
  parent :post, post
end
crumb :new_post do
  link t("views.buttons.new"), new_post_path
  parent :posts
end
crumb :posts_on_home do
  link t("activerecord.models.post"), root_path
end
crumb :post_on_home do |post|
  link post.title, root_path
  parent :posts_on_home
end

# 給料
crumb :salaries do |month|
  link "給料明細書", salaries_path(month: Date.today.strftime("%Y%m"))
  link "#{month[0..3]}年#{month[4..5]}月", salaries_path(month: month)
end

# アクセスログ
crumb :access_logs do
  link t("activerecord.models.access_log"), access_logs_path
end

# 統計
crumb :dashboards do
  link "ダッシュボード", dashboards_path
end

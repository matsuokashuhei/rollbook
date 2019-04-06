namespace :maintenance do

  "3カ月以上過去のログを消す。"
  task destroy_access_logs: :environment do
    AccessLog.where("created_at < ?", Date.today - 3.month).delete_all
  end

end

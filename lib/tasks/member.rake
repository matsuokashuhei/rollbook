require 'nkf'

namespace :db do

  task change_kana_to_members: :environment do
    ActiveRecord::Base.transaction do
      Member.all.each do |member|
        member.last_name_kana = NKF.nkf('-h1 -w', member.last_name_kana)
        member.first_name_kana = NKF.nkf('-h1 -w', member.first_name_kana)
        member.save!
      end
    end
  end
end

# == Schema Information
#
# Table name: rolls
#
#  id                 :integer          not null, primary key
#  lesson_id          :integer
#  member_id          :integer
#  status             :string(255)
#  substitute_roll_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Roll < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :member

  def substitute!(lesson)
    # 振替したレッスンの登録
    substitute_roll = Roll.create!(lesson_id: lesson.id,
                                   member_id: self.member_id,
                                   status: "4",
                                   substitute_roll_id: self.id)
    # 欠席したレッスンの更新
    self.update_attributes!(status: "3",
                            substitute_roll_id: substitute_roll.id)
  end
end

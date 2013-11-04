# == Schema Information
#
# Table name: access_logs
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  ip             :string(255)
#  remote_ip      :string(255)
#  request_method :string(255)
#  fullpath       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class AccessLog < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order("created_at DESC") }

  scope :user, -> (user_id = nil) {
    if user_id.present?
      where(user_id: user_id)
    end
  }
  scope :date_from, -> (date = nil) {
    if date.present?
      where("created_at >= ?", date.to_date)
    end
  }
  scope :date_to, -> (date = nil) {
    if date.present?
      where("created_at >= ?", date.to_date)
    end
  }
end

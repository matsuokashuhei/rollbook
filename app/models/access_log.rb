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
  scope :terms, -> (from = nil, to = nil) {
    if from.present?
      date = from.to_date
      where("created_at >= ?", date)
    end
    if to.present?
      date = to.to_date
      where("created_at <= ?", date)
    end
  }
  scope :to, -> (to = nil) {
    if to.present?
      date = to.to_date
      where("created_at >= ?", date)
    end
  }
end

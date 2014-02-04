# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  open_date  :date
#  close_date :date
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :delete_all

  validates :title, :content, :user_id, :open_date, presence: true

  scope :active, -> (date = Date.today) {
    where("open_date <= ? and ? <= coalesce(close_date, '9999-12-31')", date, date)
  }

end

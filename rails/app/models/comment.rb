# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :content, :user_id, presence: true

end

# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  zip        :string(255)
#  address    :string(255)
#  phone      :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#  open_date  :date
#  close_date :date
#

class School < ActiveRecord::Base
  has_many :studios
  default_scope -> { order("schools.open_date") }
  validates :name, :zip, :address, :phone, :open_date, presence: true
end

class School < ActiveRecord::Base
  has_many :studios
  default_scope order("schools.open_date")
  validates :name, :zip, :address, :phone, presence: true
end

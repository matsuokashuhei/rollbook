class School < ActiveRecord::Base
  has_many :studios
  validates :name, :zip, :address, :phone, presence: true
end

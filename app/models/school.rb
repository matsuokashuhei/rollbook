class School < ActiveRecord::Base
  validates :name, :zip, :address, :phone, presence: true
end

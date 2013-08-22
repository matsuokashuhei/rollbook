class Instructor < ActiveRecord::Base
  has_many :courses
  validates :name, :kana, :phone, presence: true
end

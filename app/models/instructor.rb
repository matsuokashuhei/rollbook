class Instructor < ActiveRecord::Base
  has_many :courses
  #validates :name, :kana, :phone, presence: true
  default_scope order(:kana)
  validates :name, :phone, presence: true
end

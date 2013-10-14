# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  frequency  :string(255)
#  due_date   :date
#  status     :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

class Task < ActiveRecord::Base

  NAMES = {
    DEBIT: "debit",
  }

  FREQUENCIES = {
    ONE_DAY: "O",
    DAILY: "D",
    WEEKLY: "W",
    MONTHLY: "M",
  }

  STATUSES = {
    DETERMINED: "0",
    IN_PROCESS: "1",
    FINISHED: "2",
  }

  default_scope -> { order(:frequency, :name, :due_date) }

  scope :debit, -> {
    where(frequency: FREQUENCIES[:MONTHLY], name: "debit")
  }

  validates :name, :due_date, :frequency, :status, presence: true
  validates :name, inclusion: { in: NAMES.map {|k, v| v } }
  validates :frequency, inclusion: { in: FREQUENCIES.map {|k, v| v } }
  validates :status, inclusion: { in: STATUSES.map {|k, v| v } }
  validates :due_date, uniqueness: { scope: :name }

  def delete?
    true
  end

end

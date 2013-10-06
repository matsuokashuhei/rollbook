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
    NONE: "0",
    IN_PROCESS: "1",
    FIXED: "2",
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

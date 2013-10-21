# == Schema Information
#
# Table name: tuitions
#
#  id         :integer          not null, primary key
#  month      :string(255)
#  debit_status     :string(255)
#  receipt_status     :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

class Tuition < ActiveRecord::Base
  has_many :debits
  has_many :receipts

  DEBIT_STATUSES = {
    IN_PROCESS: "1",
    FINISHED: "2"
  }
  RECEIPT_STATUSES = {
    NONE: "0",
    IN_PROCESS: "1",
    FINISHED: "2"
  }
  bank_fee = 150

  default_scope -> { order(:month) }

  #validates :month, :debit_status, :receipt_status, presence: true
  validates :month, :debit_status, presence: true
  validates :debit_status, inclusion: { in: DEBIT_STATUSES.map {|k, v| v } }
  #validates :receipt_status, inclusion: { in: RECEIPT_STATUSES.map {|k, v| v } }
  validates :month, uniqueness: true

  after_find do
    self.month = self.month[0..3] + "/" + self.month[4..5]
  end

  before_save do
    self.month = self.month.sub("/", "")
    if self.debit_status == DEBIT_STATUSES[:FINISHED]
      self.receipt_status = RECEIPT_STATUSES[:IN_PROCESS]
    end
  end

  after_save do
    self.month = self.month[0..3] + "/" + self.month[4..5]
  end

  after_create do
    date = Date.new(self.month[0..3].to_i, self.month[4..5].to_i, 1)
    # 次の条件の口座を選ぶ。
    # ・引落をしている。
    # ・会員が入会している。
    BankAccount.active(date).each do |bank_account|
      debit = self.debits.build(bank_account_id: bank_account.id,
                                amount: 0,
                                status: Debit::STATUSES[:SUCCESS])
      bank_account.members.each do |member|
        next unless member.active?
        member.members_courses.active(date).joins(:course).each do |members_course|
          debit.amount += tax_with(members_course.course.monthly_fee)
        end
      end
      debit.save if debit.amount > 0
    end
  end

  after_update do
    date = Date.new(self.month[0..3].to_i, self.month[4..5].to_i, 1)
    return unless self.receipts.count == 0
    return unless self.debit_status == DEBIT_STATUSES[:FINISHED]
    # 口座引き落とし中の入金情報を作る。
    # ・今月の引落情報がある。
    # ・引落情報の状態が引落である。
    BankAccount.joins(debits: :tuition).where(tuitions: { month: self.month }).each do |bank_account|
      debit = bank_account.debits.find_by(tuition_id: self.id)
      bank_account.members.active.each do |member|
        receipt = self.receipts.build(member_id: member.id, debit_id: debit.id, amount: 0)
        member.members_courses.active(date).joins(:course).each do |members_course|
          receipt.amount += tax_with(members_course.course.monthly_fee)
        end
        next if receipt.amount == 0
        if debit.status == Debit::STATUSES[:SUCCESS]
          receipt.date = date
          receipt.method = Receipt::METHODS[:DEBIT]
          receipt.status = Receipt::STATUSES[:PAID]
        else
          receipt.amount += bank_fee
          receipt.method = Receipt::METHODS[:CASH]
          receipt.status = Receipt::STATUSES[:UNPAID]
        end
        receipt.save
      end
    end
    # 口座手続き中
    BankAccount.nonactive.each do |bank_account|
      bank_account.members.active.each do |member|
        receipt = self.receipts.build(member_id: member.id, amount: 0)
        member.members_courses.active(date).joins(:course).each do |members_course|
          receipt.amount += tax_with(members_course.course.monthly_fee)
        end
        if receipt.amount == 0
          next
        else
          receipt.amount += bank_fee
        end
        receipt.method = Receipt::METHODS[:CASH]
        receipt.status = Receipt::STATUSES[:UNPAID]
        receipt.save
      end
    end
    # 口座なし
    Member.active.where(bank_account_id: nil).each do |member|
      receipt = self.receipts.build(member_id: member.id, amount: 0)
      member.members_courses.active(date).joins(:course).each do |members_course|
        receipt.amount += tax_with(members_course.course.monthly_fee)
      end
      if receipt.amount == 0
        next
      else
        receipt.amount += bank_fee
      end
      receipt.method = Receipt::METHODS[:CASH]
      receipt.status = Receipt::STATUSES[:UNPAID]
      receipt.save
    end
  end

  before_destroy do
    self.debits.each do | debit|
      debit.destroy
    end
  end

  def edit?
    debit_status == DEBIT_STATUSES[:IN_PROCESS]
  end

  def fix?
    debit_status == DEBIT_STATUSES[:IN_PROCESS]
  end

  def delete?
    receipt_status == RECEIPT_STATUSES[:NONE]
  end

  private

  def tax_with(amount)
    (amount * 1.05).to_i
  end
end

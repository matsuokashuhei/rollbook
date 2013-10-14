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

  default_scope -> { order(:month) }

  validates :month, :debit_status, :receipt_status, presence: true
  validates :debit_status, inclusion: { in: DEBIT_STATUSES.map {|k, v| v } }
  validates :receipt_status, inclusion: { in: RECEIPT_STATUSES.map {|k, v| v } }
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
    BankAccount.active.joins(:members).where(members: { status: Member::STATUSES[:ADMISSION] }).each do |bank_account|
      amount = 0
      bank_account.members.each do |member|
        member.members_courses.active.joins(:course).each do |members_course|
          amount += members_course.course.monthly_fee
        end
      end
      debit = self.debits.build(bank_account_id: bank_account.id,
                                amount: amount,
                                status: Debit::STATUSES[:SUCCESS])
      debit.save
    end
  end

  after_update do
    date = (self.month + "01").to_date
    return unless self.receipts.count == 0
    return unless self.debit_status == DEBIT_STATUSES[:FINISHED]
    # 口座引き落とし中
    members = Member.active.joins(bank_account: [debits: :tuition]).where(tuitions: { month: self.month })
    members.each do |member|
      receipt = self.receipts.build(member_id: member.id)
      receipt.amount = member.total_monthly_fee(date)
      debit = self.debits.find_by(bank_account_id: member.bank_account.id)
      receipt.debit_id = debit.id
      if debit.status == Debit::STATUSES[:SUCCESS]
        receipt.method = Receipt::METHODS[:DEBIT]
        receipt.status = Receipt::STATUSES[:PAID]
      else
        receipt.method = Receipt::METHODS[:CASH]
        receipt.status = Receipt::STATUSES[:UNPAID]
      end
      receipt.save
    end
    # 口座手続き中
    members = Member.active.joins(:bank_account).where("bank_accounts.status in (?)", BankAccount::not_active_statuses)
    members.each do |member|
      receipt = self.receipts.build(member_id: member.id)
      receipt.amount = member.total_monthly_fee(date)
      receipt.method = Receipt::METHODS[:CASH]
      receipt.status = Receipt::STATUSES[:UNPAID]
      receipt.save
    end
    # 口座なし
    members = Member.active.where(bank_account_id: nil)
    members.each do |member|
      receipt = self.receipts.build(member_id: member.id)
      receipt.amount = member.total_monthly_fee(date)
      receipt.method = Receipt::METHODS[:CASH]
      receipt.status = Receipt::STATUSES[:UNPAID]
      receipt.save
    end
  end

  def delete?
    receipt_status == RECEIPT_STATUSES[:NONE]
  end

end

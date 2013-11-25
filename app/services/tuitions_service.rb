class TuitionsService

  def initialize(tuition)
    @tuition = tuition
  end

  def begin
    # 口座ごとに振込情報を作る。
    beginning_of_month = @tuition.month.to_date
    BankAccount.active(beginning_of_month).each do |bank_account|
      # 振込情報を作る。
      debit = @tuition.debits.build bank_account_id: bank_account.id,
                                   amount: 0,
                                   status: Debit::STATUSES[:SUCCESS]
      # 金額を計算する。
      bank_account.members.each do |member|
        # 無効な会員をのぞく。
        next unless member.active?
        member.members_courses.active(beginning_of_month).each do |members_course|
          debit.amount += add_tax(members_course.course.monthly_fee)
        end
      end
      debit.save! if debit.amount > 0
    end
  end

  def end
    date = @tuition.month.to_date
    # -------------------
    # 月謝情報を更新する。
    # -------------------
    @tuition.debit_status = Tuition::DEBIT_STATUSES[:FINISHED]
    @tuition.receipt_status = Tuition::RECEIPT_STATUSES[:IN_PROCESS]
    @tuition.save!
    # -------------------------
    # 会員ごとに支払情報を作る。
    # -------------------------
    # 口座振替中の会員
    @tuition.debits.joins(:bank_account).each do |debit|
      bank_account = debit.bank_account
      bank_account.members.active.each do |member|
        receipt = @tuition.receipts.build member_id: member.id,
                                          debit_id: debit.id,
                                          amount: 0
        member.members_courses.active(date).joins(:course).each do |members_course|
          receipt.amount += add_tax(members_course.course.monthly_fee)
        end
        next if receipt.amount == 0
        case debit.status
        when Debit::STATUSES[:SUCCESS]
          receipt.date = Date.today
          receipt.method = Receipt::METHODS[:DEBIT]
          receipt.status = Receipt::STATUSES[:PAID]
        else
          receipt.amount += BANK_TRANSFER_FEE / bank_account.payable_members(date).count
          receipt.method = Receipt::METHODS[:CASH]
          receipt.status = Receipt::STATUSES[:UNPAID]
        end
        receipt.save!
      end
    end
    # 口座手続き中の会員
    BankAccount.in_process(date).each do |bank_account|
      bank_account.members.active.each do |member|
        receipt = @tuition.receipts.build member_id: member.id,
                                          amount: 0
        member.members_courses.active(date).joins(:course).each do |members_course|
          receipt.amount += add_tax(members_course.course.monthly_fee)
        end
        next if receipt.amount == 0
        receipt.method = Receipt::METHODS[:CASH]
        receipt.status = Receipt::STATUSES[:UNPAID]
        receipt.save!
      end
    end
    # 書類不備(口座変更)の会員
    BankAccount.invalid.each do |bank_account|
      bank_account.members.active.each do |member|
        receipt = @tuition.receipts.build member_id: member.id,
                                          amount: 0
        member.members_courses.active(date).joins(:course).each do |members_course|
          receipt.amount += add_tax(members_course.course.monthly_fee)
        end
        next if receipt.amount == 0
        receipt.amount += BANK_TRANSFER_FEE / bank_account.payable_members(date).count
        receipt.method = Receipt::METHODS[:CASH]
        receipt.status = Receipt::STATUSES[:UNPAID]
        receipt.save!
      end
    end
    # 口座なしの会員
    Member.active.where(bank_account_id: nil).each do |member|
      receipt = @tuition.receipts.build member_id: member.id,
                                        amount: 0
      member.members_courses.active(date).joins(:course).each do |members_course|
        receipt.amount += add_tax(members_course.course.monthly_fee)
      end
      next if receipt.amount == 0
      receipt.amount += BANK_TRANSFER_FEE
      receipt.method = Receipt::METHODS[:CASH]
      receipt.status = Receipt::STATUSES[:UNPAID]
      receipt.save!
    end
  end

  private

  def add_tax(amount)
    (amount + (amount * TAX_RATE)).to_i
  end
end

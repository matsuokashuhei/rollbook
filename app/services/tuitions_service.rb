class TuitionsService

  def initialize(month)
    @month = month
  end

  def begin_debit
    # 月謝情報を作る。
    tuition = Tuition.new month: @month,
                          debit_status: Tuition::DEBIT_STATUSES[:IN_PROCESS],
                          receipt_status: Tuition::RECEIPT_STATUSES[:NONE]
    tuition.save!
    # 口座ごとに振込情報を作る。
    beginning_of_month = (@month + "01").to_date
    BankAccount.active(beginning_of_month).each do |bank_account|
      # 振込情報を作る。
      debit = tuition.debits.build bank_account_id: bank_account.id,
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

  def end_debit(tuition)
    # 会員ごとに支払情報を作る。

    # 口座ありの会員
  end

  private

  def add_tax(amount)
    (amount + (amount * TAX_RATE)).to_i
  end
end

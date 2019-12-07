module Rollbook

  module Money
  
    # 消費税を計算する。
    def self.calculate_consumption_tax(amount, date = Date.today)
      tax_rate = consumption_tax_rate(date: date)
      calculate_tax(amount, tax_rate)
    end

    # 消費税込の金額にする。
    def self.include_consumption_tax(amount, date = Date.today)
      amount + calculate_consumption_tax(amount, date)
    end

    # 源泉徴収税の税率
    @@withholding_tax_rate = 0.1021

    # 源泉徴収税を計算する。
    def self.calculate_withholding_tax(amount)
      calculate_tax(amount, @@withholding_tax_rate)
    end

    # 源泉徴収税を差し引いたの金額にする。
    def self.after_withholding_tax(amount)
      amount - calculate_withholding_tax(amount)
    end

    private
    
      def self.calculate_tax(amount, tax_rate)
        if amount > 0
          (amount * tax_rate).truncate
        else
          0
        end
      end

      def self.consumption_tax_rate(date: Date.today)
        return 0.05 if date < Date.new(2014, 4, 1)
        return 0.08 if date < Date.new(2019, 10, 1)
        return 0.10
      end

  end

end

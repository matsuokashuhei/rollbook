module Rollbook

  module Money
  
    # 消費税の税率  
    @@consumption_tax_rate = 0.08

    # 消費税を計算する。
    def self.calculate_consumption_tax(amount)
      calculate_tax(amount, @@consumption_tax_rate)
    end

    # 消費税込の金額にする。
    def self.include_consumption_tax(amount)
      amount + calculate_consumption_tax(amount)
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

  end

end
require 'spec_helper'

describe Rollbook::Money do

  describe ".calculate_consumption_tax" do

    context "2014年3月31日以前の場合" do
      date = Date.new(2014, 3, 31)
      it "100円の場合は5円であること" do
        amount = Rollbook::Money.calculate_consumption_tax(100, date)
        expect(amount).to eq(5)
      end
      it "10円の場合は0円であること" do
        amount = Rollbook::Money.calculate_consumption_tax(10, date)
        expect(amount).to eq(0)
      end
      it "0円の場合は0円であること" do
        amount = Rollbook::Money.calculate_consumption_tax(0, date)
        expect(amount).to eq(0)
      end
      it "-100円の場合は0円であること" do
        amount = Rollbook::Money.calculate_consumption_tax(-100, date)
        expect(amount).to eq(0)
      end
    end

    context "2014年4月1日以降の場合" do
      date = Date.new(2014, 4, 1)
      it "100円の場合は8円であること" do
        amount = Rollbook::Money.calculate_consumption_tax(100, date)
        expect(amount).to eq(8)
      end
      it "10円の場合は0円であること" do
        amount = Rollbook::Money.calculate_consumption_tax(10, date)
        expect(amount).to eq(0)
      end
      it "0円の場合は0円であること" do
        amount = Rollbook::Money.calculate_consumption_tax(0, date)
        expect(amount).to eq(0)
      end
      it "-100円の場合は0円であること" do
        amount = Rollbook::Money.calculate_consumption_tax(-100, date)
        expect(amount).to eq(0)
      end
    end
  end

  describe ".include_consumption_tax" do
    it "100円の場合は108円であること" do
      amount = Rollbook::Money.include_consumption_tax(100)
      expect(amount).to eq(108)
    end
    it "10円の場合は10円であること" do
      amount = Rollbook::Money.include_consumption_tax(10)
      expect(amount).to eq(10)
    end
    it "0円の場合は0円であること" do
      amount = Rollbook::Money.include_consumption_tax(0)
      expect(amount).to eq(0)
    end
    it "-100円の場合は-100円であること" do
      amount = Rollbook::Money.include_consumption_tax(-100)
      expect(amount).to eq(-100)
    end
  end

  describe ".calculate_withholding_tax" do
    it "10000円の場合は1021円であること" do
      amount = Rollbook::Money.calculate_withholding_tax(10000)
      expect(amount).to eq(1021)
    end
    it "1000円の場合は102円であること" do
      amount = Rollbook::Money.calculate_withholding_tax(1000)
      expect(amount).to eq(102)
    end
    it "0円の場合は0円であること" do
      amount = Rollbook::Money.calculate_withholding_tax(0)
      expect(amount).to eq(0)
    end
    it "-1000円の場合は0円であること" do
      amount = Rollbook::Money.calculate_withholding_tax(-1000)
      expect(amount).to eq(0)
    end
  end

  describe ".after_withholding_tax" do
    it "10000円の場合は8979円であること" do
      amount = Rollbook::Money.after_withholding_tax(10000)
      expect(amount).to eq(8979)
    end
    it "1000円の場合は898円であること" do
      amount = Rollbook::Money.after_withholding_tax(1000)
      expect(amount).to eq(898)
    end
    it "0円の場合は0円であること" do
      amount = Rollbook::Money.after_withholding_tax(0)
      expect(amount).to eq(0)
    end
    it "-1000円の場合は-1000円であること" do
      amount = Rollbook::Money.after_withholding_tax(-1000)
      expect(amount).to eq(-1000)
    end
  end

end

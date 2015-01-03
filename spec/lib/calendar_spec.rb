require 'rails_helper'

describe Rollbook::Calendar do

  describe ".week_of_month" do
    
    context "1月の場合" do
      it "2015年1月8日は第1週であること。" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2015, 1, 8))
        expect(week_of_month).to eq(1)
      end
      it "2015年1月10日は第1週であること。" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2015, 1, 10))
        expect(week_of_month).to eq(1)
      end
      it "2015年1月11日は第2週であること。" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2015, 1, 11))
        expect(week_of_month).to eq(2)
      end
      it "2015年1月31日は第4週であること。" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2015, 1, 31))
        expect(week_of_month).to eq(4)
      end
    end

    context "1月以外の場合" do
      it "2015年2月1日は第1週であること。" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2015, 2, 1))
        expect(week_of_month).to eq(1)
      end
      it "2015年2月7日は第1週であること。" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2015, 2, 7))
        expect(week_of_month).to eq(1)
      end
      it "2015年2月8日は第2週であること。" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2015, 2, 8))
        expect(week_of_month).to eq(2)
      end
      it "2015年2月28日は第4週であること。" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2015, 2, 28))
        expect(week_of_month).to eq(4)
      end
      it "2015年3月31日は第5週であること。" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2015, 3, 31))
        expect(week_of_month).to eq(5)
      end
    end

  end

end

require 'rails_helper'

describe Rollbook::Calendar do

  before(:each) do
    # 1月
    [1, 2, 3].each do |day|
      Holiday.create(date: Date.new(2016, 1, day))
    end
    # 4月
    [29, 30].each do |day|
      Holiday.create(date: Date.new(2016, 4, day))
    end
    # 5月
    [1, 30, 31].each do |day|
      Holiday.create(date: Date.new(2016, 5, day))
    end
  end

  describe :business_days do
    context '2016年1月の場合' do
      it '4〜31日であること' do
        days = (Date.new(2016, 1, 4)..Date.new(2016, 1, 31)).to_a
        business_days = Rollbook::Calendar.business_days(month: '201601')
        expect(business_days).to eq(days)
      end
    end
    context '2016年4月の場合' do
      it '1〜28日であること' do
        days = (Date.new(2016, 4, 1)..Date.new(2016, 4, 28)).to_a
        business_days = Rollbook::Calendar.business_days(month: '201604')
        expect(business_days).to eq(days)
      end
    end
    context '2016年5月の場合' do
      it '2〜29日であること' do
        days = (Date.new(2016, 5, 2)..Date.new(2016, 5, 29)).to_a
        business_days = Rollbook::Calendar.business_days(month: '201605')
        expect(business_days).to eq(days)
      end
    end
  end

  describe :days_of_week do
    context '2016年1月の場合' do
      it '日曜の営業日は10〜31日であること' do
        days = [10, 17, 24, 31].map {|day| Date.new(2016, 1, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201601', wday: 0)
        expect(days_of_week).to eq(days)
      end
      it '月曜の営業日は4〜25日であること' do
        days = [4, 11, 18 ,25].map {|day| Date.new(2016, 1, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201601', wday: 1)
        expect(days_of_week).to eq(days)
      end
      it '木曜の営業日は7〜28日であること' do
        days = [7, 14, 21, 28].map {|day| Date.new(2016, 1, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201601', wday: 4)
        expect(days_of_week).to eq(days)
      end
      it '金曜の営業日は7〜28日であること' do
        days = [8, 15, 22, 29].map {|day| Date.new(2016, 1, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201601', wday: 5)
        expect(days_of_week).to eq(days)
      end
    end
    context '2016年4月の場合' do
      it '木曜の営業日は7〜28日であること' do
        days = [7, 14, 21, 28].map {|day| Date.new(2016, 4, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201604', wday: 4)
        expect(days_of_week).to eq(days)
      end
      it '金曜の営業日は1〜22日であること' do
        days = [1, 8, 15, 22].map {|day| Date.new(2016, 4, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201604', wday: 5)
        expect(days_of_week).to eq(days)
      end
      it '土曜の営業日は2〜23日であること' do
        days = [2, 9, 16, 23].map {|day| Date.new(2016, 4, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201604', wday: 6)
        expect(days_of_week).to eq(days)
      end
      it '日曜の営業日は3〜24日であること' do
        days = [3, 10, 17, 24].map {|day| Date.new(2016, 4, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201604', wday: 0)
        expect(days_of_week).to eq(days)
      end
    end
    context '2016年5月の場合' do
      it '日曜の営業日は8〜29日であること' do
        days = [8, 15, 22, 29].map {|day| Date.new(2016, 5, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201605', wday: 0)
        expect(days_of_week).to eq(days)
      end
      it '月曜の営業日は2〜23日であること' do
        days = [2, 9, 16, 23].map {|day| Date.new(2016, 5, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201605', wday: 1)
        expect(days_of_week).to eq(days)
      end
      it '火曜の営業日は3〜24日であること' do
        days = [3, 10, 17, 24].map {|day| Date.new(2016, 5, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201605', wday: 2)
        expect(days_of_week).to eq(days)
      end
      it '水曜の営業日は4〜25日であること' do
        days = [4, 11, 18, 25].map {|day| Date.new(2016, 5, day) }
        days_of_week = Rollbook::Calendar.days_of_week(month: '201605', wday: 3)
        expect(days_of_week).to eq(days)
      end
    end
  end

  describe :sundays do
    it "2016年4月の日曜日は3、10、17、24日であること" do
      days = [3, 10, 17, 24].map {|day| Date.new(2016, 4, day) }
      sundays = Rollbook::Calendar.sundays(month: '201604')
      expect(sundays).to eq(days)
    end
  end

  describe :mondays do
    it "2016年4月の月曜日は4、11、18、25日であること" do
      days = [4, 11, 18, 25].map {|day| Date.new(2016, 4, day) }
      sundays = Rollbook::Calendar.mondays(month: '201604')
      expect(sundays).to eq(days)
    end
  end

  describe :tuesdays do
    it "2016年4月の火曜日は5、12、19、26日であること" do
      days = [5, 12, 19, 26].map {|day| Date.new(2016, 4, day) }
      sundays = Rollbook::Calendar.tuesdays(month: '201604')
      expect(sundays).to eq(days)
    end
  end

  describe :wednesdays do
    it "2016年4月の水曜日は6、13、20、27日であること" do
      days = [6, 13, 20, 27].map {|day| Date.new(2016, 4, day) }
      sundays = Rollbook::Calendar.wednesdays(month: '201604')
      expect(sundays).to eq(days)
    end
  end

  describe :thursdays do
    it "2016年4月の木曜日は7、14、21、28日であること" do
      days = [7, 14, 21, 28].map {|day| Date.new(2016, 4, day) }
      sundays = Rollbook::Calendar.thursdays(month: '201604')
      expect(sundays).to eq(days)
    end
  end

  describe :fridays do
    #it "2016年4月の金曜日は1、8、15、22、29日であること" do
    it "2016年4月の金曜日は1、8、15、22日であること" do
      #days = [1, 8, 15, 22, 29].map {|day| Date.new(2016, 4, day) }
      days = [1, 8, 15, 22].map {|day| Date.new(2016, 4, day) }
      sundays = Rollbook::Calendar.fridays(month: '201604')
      expect(sundays).to eq(days)
    end
  end

  describe :saturdays do
    #it "2016年4月の土曜日は2、9、16、23、30日であること" do
    it "2016年4月の土曜日は2、9、16、23日であること" do
      #days = [2, 9, 16, 23, 30].map {|day| Date.new(2016, 4, day) }
      days = [2, 9, 16, 23].map {|day| Date.new(2016, 4, day) }
      sundays = Rollbook::Calendar.saturdays(month: '201604')
      expect(sundays).to eq(days)
    end
  end

  describe :week_of_month do

    context '1月の場合' do
      it '1〜3日はnilであること' do
        (1..3).each do |day|
          date = Date.new(2016, 1, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to be_nil
        end
      end
      it '4〜10日は1週であること' do
        (4..10).each do |day|
          date = Date.new(2016, 1, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to eq(1)
        end
      end
      it '11〜17日は2週であること' do
        (11..17).each do |day|
          date = Date.new(2016, 1, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to eq(2)
        end
      end
      it '25〜31日は4週であること' do
        (25..31).each do |day|
          date = Date.new(2016, 1, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to eq(4)
        end
      end
    end

    context '4月の場合' do
      it '1〜7日は1週であること' do
        (1..7).each do |day|
          date = Date.new(2016, 4, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to eq(1)
        end
      end
      it '8〜14日は2週であること' do
        (8..14).each do |day|
          date = Date.new(2016, 4, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to eq(2)
        end
      end
      it '22〜28日は4週であること' do
        (22..28).each do |day|
          date = Date.new(2016, 4, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to eq(4)
        end
      end
      it '29〜30日はnilであること' do
        (29..30).each do |day|
          date = Date.new(2016, 4, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to be_nil
        end
      end
    end

    context '5月の場合' do
      it '1、30、31日はnilであること' do
        [1, 30, 31].each do |day|
          date = Date.new(2016, 5, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to be_nil
        end
      end
      it '2〜8日は1週であること' do
        (2..8).each do |day|
          date = Date.new(2016, 5, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to eq(1)
        end
      end
      it '9〜15日は2週であること' do
        (9..15).each do |day|
          date = Date.new(2016, 5, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to eq(2)
        end
      end
      it '23〜29日は4週であること' do
        (23..29).each do |day|
          date = Date.new(2016, 5, day)
          week_of_month = Rollbook::Calendar.week_of_month(date: date)
          expect(week_of_month).to eq(4)
        end
      end
    end
  
  end

=begin
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

    context "2016年5月の場合" do
      it "1日は休日であること" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2016, 5, 1))
        expect(week_of_month).to eq(0)
      end
      it "2日は第1週であること" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2016, 5, 2))
        expect(week_of_month).to eq(1)
      end
      it "8日は第1週であること" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2016, 5, 8))
        expect(week_of_month).to eq(1)
      end
      it "9日は第2週であること" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2016, 5, 9))
        expect(week_of_month).to eq(2)
      end
      it "29日は第4週であること" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2016, 5, 29))
        expect(week_of_month).to eq(4)
      end
      it "30日は休日であること" do
        week_of_month = Rollbook::Calendar.week_of_month(date: Date.new(2016, 5, 30))
        expect(week_of_month).to eq(0)
      end
    end
  end
=end

end

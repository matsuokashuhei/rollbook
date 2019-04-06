# == Schema Information
#
# Table name: holidays
#
#  id         :integer          not null, primary key
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Holiday do

  before(:each) do
    @days = [Date.new(2016, 5, 1), Date.new(2016, 5, 30), Date.new(2016, 5, 31)]
    @days.each do |date|
      Holiday.create(date: date)
    end
  end

  describe :workday? do
    it '5月1日は営業日ではないこと' do
      date = Date.new(2016, 5, 1)
      expect(Holiday.workday?(date)).to eq(false)
    end
    it '5月2日は営業日であること' do
      date = Date.new(2016, 5, 2)
      expect(Holiday.workday?(date)).to eq(true)
    end
  end

  describe :holiday? do
    it '5月1日は営業日ではないこと' do
      date = Date.new(2016, 5, 1)
      expect(Holiday.holiday?(date)).to eq(true)
    end
    it '5月2日は営業日であること' do
      date = Date.new(2016, 5, 2)
      expect(Holiday.holiday?(date)).to eq(false)
    end
  end

  describe :days_off do
    it '2016年5月の休日は1日、30日、31日であること' do
      days_off = Holiday.days_off(month: '201605')
      expect(days_off.pluck(:date)).to eq(@days)
    end
  end
end

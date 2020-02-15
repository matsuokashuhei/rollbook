# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  zip        :string(255)
#  address    :string(255)
#  phone      :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#  open_date  :date
#  close_date :date
#

require 'rails_helper'

describe School do
 
  describe 'validation' do

    before :each do
      @school = School.new(name: '立川校', open_date: Date.today)
    end
 
    context 'name、open_dateがある場合' do
      it 'is valid' do
        expect(@school).to be_valid
      end
    end
 
    context 'nameがない場合' do
      before :each do
        @school.name = nil
      end
      it 'is invalid' do
        expect(@school).to be_invalid
        expect(@school.errors[:name]).to include('を入力してください。')
      end
    end
 
    context 'open_dateがない場合' do
      before :each do
        @school.open_date = nil
      end
      it 'is invalid' do
        expect(@school).to be_invalid
        #expect(@school.errors).to include(:open_date)
        expect(@school.errors[:open_date]).to include('を入力してください。')
      end
    end

    context 'nameが同じschoolがすでにある場合' do
      before :each do
        @school.save
        @school = School.new(name: '立川校', open_date: Date.today)
      end
      it 'is invalid' do
        expect(@school).to be_invalid
        #expect(@school.errors).to include(:name)
        expect(@school.errors[:name]).to include('はすでに存在します。')
      end
    end
  end

  describe '#tuition_fee' do
    before :each do
      @school = School.create(name: '立川校', open_date: Date.today)
      studio = @school.studios.build(name: '立川Aスタジオ', open_date: Date.today)
      allow(studio).to receive(:tuition_fee).and_return(100)
      studio = @school.studios.build(name: '立川Bスタジオ', open_date: Date.today)
      allow(studio).to receive(:tuition_fee).and_return(200)
    end
    context 'Aスタジオの月謝収入が100円で、Bスタジオの月謝収入が200の場合' do
      it 'スクールの月謝収入は300円であること。' do
        expect(@school.tuition_fee(month: '201412')).to eq(300)
      end
    end
  end

end

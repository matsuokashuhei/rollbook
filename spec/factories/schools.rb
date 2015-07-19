FactoryGirl.define do

  factory :立川校, class: School do
    name '立川校'
    open_date Date.new(2007, 4, 1)
  end
  factory :国分寺校, class: School do
    name '国分寺校'
    open_date Date.new(2010, 4, 1)
  end
  factory :田無校, class: School do
    name '田無校'
    open_date Date.new(2014, 4, 1)
  end

end
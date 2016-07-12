FactoryGirl.define do
  factory :week do
    start_date Date.parse('2016-06-25')
    swap_date Date.parse('2016-06-27')
  end
end

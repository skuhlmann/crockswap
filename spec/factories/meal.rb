FactoryGirl.define do
  factory :meal do
    name "Hot Dogs"
    shop_date Date.parse('2016-06-27')
    cook_date Date.parse('2016-06-28')
    freezable true
    covered false
    timing_to_eat "2 days"
    cooking_degrees "300 f"
    cooking_time "25 minuets"
  end
end
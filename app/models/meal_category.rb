class MealCategory < ActiveRecord::Base
  has_many :meals
end

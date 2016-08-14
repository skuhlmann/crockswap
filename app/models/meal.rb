class Meal < ActiveRecord::Base
  belongs_to :user
  belongs_to :week
  belongs_to :category, class_name: MealCategory, foreign_key: "meal_category_id"
  has_many :ratings, class_name: MealRating
end
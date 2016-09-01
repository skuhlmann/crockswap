class Meal < ActiveRecord::Base
  belongs_to :user
  belongs_to :week
  belongs_to :category, class_name: MealCategory, foreign_key: "meal_category_id"

  validates :category, uniqueness: { scope: :week, 
    message: "That category is already taken" }

  ratyrate_rateable 'rating'
end
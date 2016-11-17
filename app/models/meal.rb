class Meal < ActiveRecord::Base
  belongs_to :user
  belongs_to :week
  belongs_to :category, class_name: MealCategory, foreign_key: "meal_category_id"

  before_save :parse_url

  validates :category, uniqueness: { scope: :week, 
    message: "That category is already taken" }

  ratyrate_rateable 'rating'

  def parse_url
    if self.recipe_url && !self.recipe_url.include?("http")
      self.recipe_url = "http://#{recipe_url}"
    end
  end
end
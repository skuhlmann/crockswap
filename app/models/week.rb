class Week < ActiveRecord::Base
  belongs_to :groups
  has_many :meals

  def available_categories
    categories = MealCategory.all
    meal_category_ids = meals.pluck(:meal_category_id)
    categories.reject do |category|
      meal_category_ids.any? { |id| id == category.id }
    end
  end
end

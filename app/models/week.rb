class Week < ActiveRecord::Base
  belongs_to :group
  has_many :meals

  def available_categories
    categories = MealCategory.all
    meal_category_ids = meals.pluck(:meal_category_id)
    categories.reject do |category|
      meal_category_ids.any? { |id| id == category.id }
    end
  end

  def is_past?
    Date.today > (start_date + 7)
  end
end

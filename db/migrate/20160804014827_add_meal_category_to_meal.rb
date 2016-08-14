class AddMealCategoryToMeal < ActiveRecord::Migration
  def change
    add_reference :meals, :meal_category, index: true, foreign_key: true
  end
end

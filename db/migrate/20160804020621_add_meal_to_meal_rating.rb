class AddMealToMealRating < ActiveRecord::Migration
  def change
    add_reference :meal_ratings, :meal, index: true, foreign_key: true
  end
end

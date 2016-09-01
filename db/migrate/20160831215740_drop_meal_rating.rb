class DropMealRating < ActiveRecord::Migration[5.0]
  def change
    drop_table :meal_ratings
  end
end

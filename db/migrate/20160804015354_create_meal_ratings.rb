class CreateMealRatings < ActiveRecord::Migration
  def change
    create_table :meal_ratings do |t|
      t.integer :rating
      t.string :comment

      t.timestamps null: false
    end
  end
end

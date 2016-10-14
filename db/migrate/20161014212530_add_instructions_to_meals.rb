class AddInstructionsToMeals < ActiveRecord::Migration[5.0]
  def change
    add_column :meals, :instructions, :string

    remove_column :meals, :shop_date, :date
    remove_column :meals, :cook_date, :date
    remove_column :meals, :cooking_time, :string
    remove_column :meals, :cooking_degrees, :string
    remove_column :meals, :timing_to_eat, :string
    remove_column :meals, :covered, :boolean
    remove_column :meals, :freezable, :boolean
  end
end

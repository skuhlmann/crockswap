class AddAccompanimentsToMeals < ActiveRecord::Migration[5.0]
  def change
    add_column :meals, :accompaniments, :string
  end
end

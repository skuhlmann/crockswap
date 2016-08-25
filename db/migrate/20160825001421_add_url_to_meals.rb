class AddUrlToMeals < ActiveRecord::Migration[5.0]
  def change
    add_column :meals, :recipe_url, :string
  end
end

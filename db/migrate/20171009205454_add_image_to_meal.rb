class AddImageToMeal < ActiveRecord::Migration[5.0]
  def change
    add_attachment :meals, :picture
  end
end

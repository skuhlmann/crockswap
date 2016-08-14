class AddDirectionFieldsToMeals < ActiveRecord::Migration
  def change
    change_table :meals do |t|
      t.string :cooking_time
      t.string :cooking_degrees
      t.boolean :covered
      t.string :timing_to_eat
      t.boolean :freezable
    end
  end
end

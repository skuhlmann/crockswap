class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.date :shop_date
      t.date :cook_date

      t.timestamps null: false
    end
  end
end

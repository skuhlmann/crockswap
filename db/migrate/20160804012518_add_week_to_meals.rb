class AddWeekToMeals < ActiveRecord::Migration
  def change
    add_reference :meals, :week, index: true, foreign_key: true
  end
end

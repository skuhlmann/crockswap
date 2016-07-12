class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.date :swap_date
      t.date :start_date
      t.string :swap_location

      t.timestamps null: false
    end
  end
end

class AddTimeToWeeks < ActiveRecord::Migration[5.0]
  def change
    add_column :weeks, :swap_time, :string
  end
end

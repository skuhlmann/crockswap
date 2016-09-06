class AddPausedToWeeks < ActiveRecord::Migration[5.0]
  def change
    add_column :weeks, :paused, :boolean, default: false
  end
end

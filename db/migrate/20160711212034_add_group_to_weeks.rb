class AddGroupToWeeks < ActiveRecord::Migration
  def change
    add_reference :weeks, :group, index: true, foreign_key: true
  end
end

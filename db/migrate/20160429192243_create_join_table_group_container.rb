class CreateJoinTableGroupContainer < ActiveRecord::Migration
  def change
    create_join_table :groups, :containers do |t|
      # t.index [:group_id, :container_id]
      # t.index [:container_id, :group_id]
    end
  end
end

class CreateJoinTableGroupRestriction < ActiveRecord::Migration
  def change
    create_join_table :groups, :diet_restrictions do |t|
      # t.index [:group_id, :diet_restriction_id]
      # t.index [:diet_restriction_id, :group_id]
    end
  end
end

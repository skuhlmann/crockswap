class CreateJoinTableUserRestriction < ActiveRecord::Migration
  def change
    create_join_table :users, :diet_restrictions do |t|
      # t.index [:user_id, :diet_restriction_id]
      # t.index [:diet_restriction_id, :user_id]
    end
  end
end

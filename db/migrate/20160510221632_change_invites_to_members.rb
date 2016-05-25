class ChangeInvitesToMembers < ActiveRecord::Migration
  def change
    rename_table :invites, :members
  end
end

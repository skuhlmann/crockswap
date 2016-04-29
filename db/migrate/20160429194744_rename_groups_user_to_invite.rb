class RenameGroupsUserToInvite < ActiveRecord::Migration
  def change
    rename_table :groups_users, :invites
  end
end

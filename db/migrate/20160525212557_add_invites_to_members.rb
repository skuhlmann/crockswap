class AddInvitesToMembers < ActiveRecord::Migration
  def change
    add_column :members, :status, :string
    add_column :members, :invite_token, :string
    add_column :members, :invite_sent_at, :datetime
  end
end

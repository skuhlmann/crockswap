class AddEmailOptOutToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :email_opt, :boolean, default: true
  end
end

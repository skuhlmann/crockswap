class AddGroupRefToMessages < ActiveRecord::Migration[5.0]
  def change
    add_reference :messages, :group, foreign_key: true
    add_attachment :messages, :picture
  end
end

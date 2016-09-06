class AddDetailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :description, :string
    add_attachment :users, :avatar
  end
end

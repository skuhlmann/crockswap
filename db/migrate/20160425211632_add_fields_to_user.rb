class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :cooking_level, :integer
    add_column :users, :name, :string
    add_column :users, :zip_code, :integer
    add_column :users, :city, :string
  end
end

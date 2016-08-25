class RemoveSwapLocationFromGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :swap_location, :string
  end
end

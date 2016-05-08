class AddSwapLocationToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :swap_location, :string
  end
end

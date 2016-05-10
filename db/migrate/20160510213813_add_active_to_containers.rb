class AddActiveToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :active, :boolean, default: true
  end
end

class DropContainersGroups < ActiveRecord::Migration
  def change
    drop_table :containers_groups
  end
end

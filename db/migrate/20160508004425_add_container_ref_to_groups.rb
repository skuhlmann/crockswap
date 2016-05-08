class AddContainerRefToGroups < ActiveRecord::Migration
  def change
    add_reference :groups, :container, index: true, foreign_key: true
  end
end

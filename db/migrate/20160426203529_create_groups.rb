class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :max_participants
      t.decimal :budget
      t.string :container_type

      t.timestamps null: false
    end
  end
end

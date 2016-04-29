class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :name
      t.string :size

      t.timestamps null: false
    end
  end
end

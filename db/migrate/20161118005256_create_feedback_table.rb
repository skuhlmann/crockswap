class CreateFeedbackTable < ActiveRecord::Migration[5.0]
  def change
    create_table :feedback do |t|
      t.integer :rating
      t.string :feedback
      t.belongs_to :user, index: true
      t.belongs_to :meal, index: true

      t.timestamps
    end
  end
end

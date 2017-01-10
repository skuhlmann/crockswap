class AddFeedbackTable < ActiveRecord::Migration[5.0]
  def change
    create_table :testing_comments do |t|
      t.string :email
      t.string :name
      t.string :comments
      
      t.timestamps
    end
  end
end

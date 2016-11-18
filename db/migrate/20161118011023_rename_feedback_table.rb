class RenameFeedbackTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :feedback, :reviews
  end
end

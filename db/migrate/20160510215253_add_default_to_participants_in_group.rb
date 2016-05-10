class AddDefaultToParticipantsInGroup < ActiveRecord::Migration
  def change
    change_column :groups, :max_participants, :integer, default: 1
  end
end

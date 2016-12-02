class AddLeaderboardToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :leaderboard, :boolean, default: false
  end
end

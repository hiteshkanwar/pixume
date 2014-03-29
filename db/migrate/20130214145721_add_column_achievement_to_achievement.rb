class AddColumnAchievementToAchievement < ActiveRecord::Migration
  def change
    add_column :achievements, :achievement, :integer, :default => 0
  end
end

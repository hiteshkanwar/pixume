class AddColumnExpertiseLevelIdToSkillSet < ActiveRecord::Migration
  def change
    add_column :skill_sets, :expertise_level_id, :integer
  end
end

class AddColumnLinkedinIdToSkillSet < ActiveRecord::Migration
  def change
    add_column :skill_sets, :linkedin_id, :string
  end
end

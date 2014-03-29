class CreateSkillSets < ActiveRecord::Migration
  def change
    create_table :skill_sets do |t|
      t.integer :user_id
      t.string :name
      t.string :expertise_level
      t.string :category
      t.timestamps
    end
  end
end

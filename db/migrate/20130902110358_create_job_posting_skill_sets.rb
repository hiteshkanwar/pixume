class CreateJobPostingSkillSets < ActiveRecord::Migration
  def change
    create_table :job_posting_skill_sets do |t|
      t.integer :job_id
      t.string :name

      t.timestamps
    end
  end
end

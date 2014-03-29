class CreateResumeFiles < ActiveRecord::Migration
  def change
    create_table :resume_files do |t|
      t.references :job_application

      t.timestamps
    end
    add_index :resume_files, :job_application_id
  end
end

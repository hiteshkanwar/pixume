class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.integer :job_posting_id
      t.integer :user_id

      t.timestamps
    end
  end
end

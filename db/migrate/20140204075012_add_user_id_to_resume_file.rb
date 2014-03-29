class AddUserIdToResumeFile < ActiveRecord::Migration
  def change
    add_column :resume_files, :user_id, :integer
  end
end

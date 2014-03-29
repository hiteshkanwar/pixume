class AddAttachmentFileToResumeFiles < ActiveRecord::Migration
  def self.up
    change_table :resume_files do |t|
      t.has_attached_file :file
    end
  end

  def self.down
    drop_attached_file :resume_files, :file
  end
end

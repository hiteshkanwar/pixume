class AddAttachmentProfileImageToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.has_attached_file :profile_image
    end
  end

  def self.down
    drop_attached_file :users, :profile_image
  end
end
  
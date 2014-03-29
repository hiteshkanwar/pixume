class AddAttachmentLogoToResources < ActiveRecord::Migration
  def self.up
    change_table :resources do |t|
      t.has_attached_file :logo
    end
  end

  def self.down
    drop_attached_file :resources, :logo
  end
end

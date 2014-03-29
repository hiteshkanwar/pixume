class AddPublishedProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :published_profile, :boolean, :default => false
  end
end

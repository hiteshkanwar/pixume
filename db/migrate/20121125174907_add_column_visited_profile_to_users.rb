class AddColumnVisitedProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visited_profile, :boolean, :default => false
  end
end

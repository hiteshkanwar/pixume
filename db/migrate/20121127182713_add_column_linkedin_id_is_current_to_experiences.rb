class AddColumnLinkedinIdIsCurrentToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :linkedin_id, :string
    add_column :experiences, :is_current, :boolean, :default => false
  end
end

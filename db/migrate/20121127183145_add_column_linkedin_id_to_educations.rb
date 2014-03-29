class AddColumnLinkedinIdToEducations < ActiveRecord::Migration
  def change
    add_column :educations, :linkedin_id, :string
  end
end

class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|
      t.integer :user_id
      t.integer :company_id
      t.string :title, :null => false
      t.string :description, :null => false
      t.string :requirements, :null => false
      t.string :salary
      t.integer :min_years_exp
      t.integer :max_years_exp
      t.string :location, :null => false
      t.string :country, :null => false
      t.boolean :show_matching_profiles, :default => false, :null => false
      t.boolean :is_public, :default => false, :null => false

      t.timestamps
    end
  end
end

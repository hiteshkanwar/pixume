class AddFieldToJobApplication < ActiveRecord::Migration
  def change
    add_column :job_applications, :availablity, :integer
    add_column :job_applications, :expected_salary, :integer
    add_column :job_applications, :best_fit_for_job, :string
  end
end

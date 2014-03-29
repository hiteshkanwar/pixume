class AddCurrencyFieldToJobApplication < ActiveRecord::Migration
  def change
    add_column :job_applications, :currency, :string
  end
end

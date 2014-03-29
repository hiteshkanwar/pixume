class AddCompanyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_id, :integer, :null => false, :default => 1
  end
end

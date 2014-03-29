class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name, :null => false
      t.string :company_industry, :null => false
      t.string :company_desc, :null => false
      t.string :company_location, :null => false
      t.string :company_country, :null => false

      t.timestamps
    end
    add_index :companies, :company_name, :unique => true
    add_index :companies, :company_location
    add_index :companies, :company_country
  end
end

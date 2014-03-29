class Company < ActiveRecord::Base
  attr_accessible :company_country, :company_desc, :company_industry, :company_location, :company_name

  validates :company_country, :company_desc, :company_industry, :company_location, :company_name, :presence => true
  validates :company_desc, :length => { :maximum => 2000 }
end

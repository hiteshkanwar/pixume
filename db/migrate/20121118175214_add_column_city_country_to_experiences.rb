class AddColumnCityCountryToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :city, :string
    add_column :experiences, :country, :string
  end
end

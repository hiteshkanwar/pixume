class AddResourceNameToResource < ActiveRecord::Migration
  def change
    add_column :resources, :resource_name, :string
  end
end

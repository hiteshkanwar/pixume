class AddCheckBoxFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :checked, :boolean
  end
end

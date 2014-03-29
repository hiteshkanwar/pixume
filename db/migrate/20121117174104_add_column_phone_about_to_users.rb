class AddColumnPhoneAboutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :about, :string
  end
end

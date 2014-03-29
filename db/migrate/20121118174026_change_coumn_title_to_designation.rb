class ChangeCoumnTitleToDesignation < ActiveRecord::Migration
  def up
    rename_column :experiences, :title, :designation
  end

  def down
    rename_column :experiences, :designation, :title
  end
end

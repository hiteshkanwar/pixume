class CreateAchievementCategories < ActiveRecord::Migration
  def change
    create_table :achievement_categories do |t|
      t.string :name, :null => false
      t.string :description
      t.boolean :is_public

      t.timestamps
    end
    add_index :achievement_categories, :name, :unique => true
  end
end

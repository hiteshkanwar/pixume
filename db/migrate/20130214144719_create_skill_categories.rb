class CreateSkillCategories < ActiveRecord::Migration
  def change
    create_table :skill_categories do |t|
      t.string :name, :null => false
      t.string :description
      t.boolean :is_public

      t.timestamps
    end
    add_index :skill_categories, :name, :unique => true
  end
end

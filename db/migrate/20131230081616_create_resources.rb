class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :description
      t.string :paid
      t.string :link
      t.string :source
      t.integer :user_id
      t.boolean :approved
      t.references :skill_set

      t.timestamps
    end
    add_index :resources, :skill_set_id
  end
end

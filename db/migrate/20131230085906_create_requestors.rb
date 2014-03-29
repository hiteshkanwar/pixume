class CreateRequestors < ActiveRecord::Migration
  def change
    create_table :requestors do |t|
      t.string :requestor_name
      t.string :requestor_email
      t.date :requested_date
      t.integer :user_id
      t.integer :skill_set_id

      t.timestamps
    end
  end
end

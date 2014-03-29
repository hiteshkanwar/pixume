class CreateUsageTrackings < ActiveRecord::Migration
  def change
    create_table :usage_trackings do |t|
      t.string :session_id
      t.string :user_name
      t.string :user_email
      t.string :last_access_url

      t.timestamps
    end
  end
end

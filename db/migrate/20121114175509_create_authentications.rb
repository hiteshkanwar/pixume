class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :access_token
      t.string :access_token_secret
      t.string :expires_in
      t.text :api_response
      t.timestamps
    end
  end
end

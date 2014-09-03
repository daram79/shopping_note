class CreateBeRequestedFriends < ActiveRecord::Migration
  def change
    create_table :be_requested_friends do |t|
      t.integer :user_id
      t.integer :request_user_id
      t.timestamps
    end
  end
end

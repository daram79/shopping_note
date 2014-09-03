class CreateUserRelations < ActiveRecord::Migration
  def change
    create_table :user_relations do |t|
      t.integer :user_id
      t.integer :friend_user_id
      t.boolean :is_friend, default: false
      t.timestamps
    end
  end
end

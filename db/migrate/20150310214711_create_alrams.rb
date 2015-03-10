class CreateAlrams < ActiveRecord::Migration
  def change
    create_table :alrams do |t|
      t.integer :alram_id
      t.string  :alram_type
      t.integer  :user_id
      t.integer  :friend_user_id
      t.timestamps
    end
  end
end

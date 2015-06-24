class CreateDeleteRecommendUsers < ActiveRecord::Migration
  def change
    create_table :delete_recommend_users do |t|
      t.integer :user_id
      t.integer :recommend_user_id
      t.timestamps
    end
    add_index :delete_recommend_users, :user_id
  end
end

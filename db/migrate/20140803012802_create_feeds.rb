class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.integer :feed_type_id
      t.text  :content
      t.timestamps
    end
  end
end

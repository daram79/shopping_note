class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.integer :feed_type_id
      t.text  :content
      t.text  :html_content
      t.integer :like_count, default: 0
      t.integer :comment_count, default: 0
      t.timestamps
    end
    add_index :feeds, [:id, :feed_type_id]
  end
end

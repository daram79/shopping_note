class CreateFeedTags < ActiveRecord::Migration
  def change
    create_table :feed_tags do |t|
      t.integer :feed_id
      t.string  :tag_name
      t.timestamps
    end
  end
end

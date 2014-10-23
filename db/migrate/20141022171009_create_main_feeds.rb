class CreateMainFeeds < ActiveRecord::Migration
  def change
    create_table :main_feeds do |t|
      t.integer :user_id
      t.integer :main_id
      t.string  :main_type  #Feed
      t.string  :sub_type  #내글(친구글), 좋아요한글
      t.timestamps
    end
  end
end

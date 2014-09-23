class CreateFeedData < ActiveRecord::Migration
  def change
    create_table :feed_data do |t|
      t.integer :user_id
      t.integer :feed_id
      t.string  :feed_type  #내글(친구글), 좋아요한글
      t.timestamps
    end
  end
end

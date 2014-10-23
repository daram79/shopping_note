class RenameFeedIdFromFeedData < ActiveRecord::Migration
  def change
    rename_column :feed_data, :feed_id, :main_id
    rename_column :feed_data, :feed_type, :main_type
  end
end

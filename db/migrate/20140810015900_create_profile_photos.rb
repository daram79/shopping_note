class CreateProfilePhotos < ActiveRecord::Migration
  def change
    create_table :profile_photos do |t|
      t.integer :user_id
      t.string  :image

      t.timestamps
    end
  end
end

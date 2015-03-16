class AddRegiIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :registration_id, :text
  end
end

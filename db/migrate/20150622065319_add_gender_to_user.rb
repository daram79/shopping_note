class AddGenderToUser < ActiveRecord::Migration
  def change
    add_column :users, :gender, :boolean, :default => false
  end
end

class AddSendFlgToAlrams < ActiveRecord::Migration
  def change
    add_column :alrams, :send_flg, :boolean, :default => false
  end
end

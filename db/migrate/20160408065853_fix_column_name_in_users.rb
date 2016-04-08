class FixColumnNameInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :phone_number, :email
  end
end

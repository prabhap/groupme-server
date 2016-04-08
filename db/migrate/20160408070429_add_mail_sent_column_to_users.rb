class AddMailSentColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mail_sent, :boolean
  end
end

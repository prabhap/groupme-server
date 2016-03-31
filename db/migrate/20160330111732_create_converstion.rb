class CreateConverstion < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :group_id
      t.string :text
    end
  end
end

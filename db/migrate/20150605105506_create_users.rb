class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :sender
      t.integer :reciver

      t.timestamps
    end
    add_index :users, :sender
    add_index :users, :reciver
  end
end

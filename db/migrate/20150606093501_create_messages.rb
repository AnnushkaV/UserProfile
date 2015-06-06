class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :belongs_to
      t.sender, :
      t.string :belongs_to
      t.reciver :
      t.text :body

      t.timestamps null: false
    end
  end
end

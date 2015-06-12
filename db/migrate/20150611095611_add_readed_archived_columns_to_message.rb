class AddReadedArchivedColumnsToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :readed, :boolean, :default => false
    add_column :messages, :archived, :boolean, :default => false
    add_index  :messages, :readed
    add_index  :messages, :archived
  end
end

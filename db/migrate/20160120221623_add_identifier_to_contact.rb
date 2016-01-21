class AddIdentifierToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :identifier, :string
    add_index :contacts, [:identifier,:account_id], unique: true
  end
end

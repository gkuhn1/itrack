class AccountTokenUniquiness < ActiveRecord::Migration
  def change
    change_column :accounts, :token, :string, unique: true
    add_index :accounts, :token, unique: true
  end
end

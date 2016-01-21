class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index(:contacts, [:email,:account_id], unique: true)
  end
end

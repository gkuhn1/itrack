class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :contact, index: true, foreign_key: true
      t.text :body
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

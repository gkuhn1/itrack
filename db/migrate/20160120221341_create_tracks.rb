class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :page
      t.string :page_title
      t.references :account, index: true, foreign_key: true
      t.references :contact, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

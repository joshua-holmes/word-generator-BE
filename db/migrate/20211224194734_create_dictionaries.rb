class CreateDictionaries < ActiveRecord::Migration[6.1]
  def change
    create_table :dictionaries do |t|
      t.string :name
      t.string :words
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

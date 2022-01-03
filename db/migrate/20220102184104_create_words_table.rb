class CreateWordsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :word
    end
    remove_column :lexicons, :words, :string
    remove_column :lexicons, :updated_at, :datetime
  end
end

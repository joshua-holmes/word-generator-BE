class RemoveJoinTableForFakeWords < ActiveRecord::Migration[6.1]
  def change
    drop_table :fake_words
    remove_column :favorite_words, :fake_word_id, :integer
    add_column :favorite_words, :word, :string
  end
end

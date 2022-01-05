class CreateFavoriteWordsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_words do |t|
      t.integer :fake_word_id
      t.integer :lexicon_id
    end
  end
end

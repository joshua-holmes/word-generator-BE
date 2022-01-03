class CreateLexiconWordsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :lexicon_words do |t|
      t.integer :lexicon_id
      t.integer :word_id
    end
  end
end

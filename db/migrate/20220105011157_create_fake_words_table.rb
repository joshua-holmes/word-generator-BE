class CreateFakeWordsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :fake_words do |t|
      t.string :word
    end
  end
end

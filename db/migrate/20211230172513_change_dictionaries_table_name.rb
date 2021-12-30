class ChangeDictionariesTableName < ActiveRecord::Migration[6.1]
  def change
    rename_table :dictionaries, :lexicons
  end
end

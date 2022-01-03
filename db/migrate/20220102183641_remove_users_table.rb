class RemoveUsersTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :users
    remove_column :lexicons, :user_id
  end
end

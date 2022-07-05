class UsersIdToUserId < ActiveRecord::Migration[7.0]
  def change
  end
end

class UsersIdToUserId < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :_id, :user_id
  end
end

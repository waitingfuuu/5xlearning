# frozen_string_literal: true

class UserRenamePasswordDigest < ActiveRecord::Migration[7.0]
  def up
    rename_column :users, :password, :password_digest
  end

  def down
    rename_column :users, :password_digest, :password
  end
end

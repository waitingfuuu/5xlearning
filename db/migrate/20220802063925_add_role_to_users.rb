# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :role, :string, null: false, default: 'general'
  end

  def down
    remove_column :users, :role, :string, null: false, default: 'general'
  end
end

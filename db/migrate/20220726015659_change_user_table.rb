# frozen_string_literal: true

class ChangeUserTable < ActiveRecord::Migration[7.0]
  def up
    change_table :users, bulk: true do |t|
      t.change :name, :string, null: false
      t.change :password, :string, null: false
    end
  end

  def down
    change_table :users, bulk: true do |t|
      t.change :name, :string, null: true
      t.change :password, :string, null: true
    end
  end
end

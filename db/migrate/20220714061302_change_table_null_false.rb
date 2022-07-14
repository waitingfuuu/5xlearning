# frozen_string_literal: true

class ChangeTableNullFalse < ActiveRecord::Migration[7.0]
  def up
    change_table :tasks, bulk: true do |t|
      t.change :title, :string, null: false
    end
  end

  def down
    change_table :tasks, bulk: true do |t|
      t.change :title, :string, null: true
    end
  end
end

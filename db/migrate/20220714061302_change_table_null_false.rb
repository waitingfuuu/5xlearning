# frozen_string_literal: true

class ChangeTableNullFalse < ActiveRecord::Migration[7.0]
  def up
    change_table :tasks, bulk: true do |t|
      t.change :title, :string, null: false
      t.change :content, :string, null: false
      t.change :tag, :string, null: false
    end
  end

  def down
    change_table :tasks, bulk: true do |t|
      t.change :title, :string, null: true
      t.change :content, :string, null: true
      t.change :tag, :string, null: true
    end
  end
end

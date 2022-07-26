# frozen_string_literal: true

class AddUserToTasks < ActiveRecord::Migration[7.0]
  def up
    change_table :tasks do |t|
      t.belongs_to :user, index: true
    end
  end

  def down
    change_table :tasks do |t|
      t.remove_references :user
    end
  end
end

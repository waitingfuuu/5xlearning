# frozen_string_literal: true

class DeleteTasksUserId < ActiveRecord::Migration[7.0]
  def up
    remove_column :tasks, :user_id
  end

  def down
    add_column :tasks, :user_id, :integer
  end
end

# frozen_string_literal: true

class CreateUserTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tasks do |t|
      t.belongs_to :user, index: true
      t.belongs_to :task, index: true

      t.timestamps
    end
  end
end

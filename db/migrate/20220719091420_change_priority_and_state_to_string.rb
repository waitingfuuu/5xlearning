# frozen_string_literal: true

class ChangePriorityAndStateToString < ActiveRecord::Migration[7.0]
  def up
    change_table :tasks, bulk: true do |t|
      t.change :priority, :string
      t.change :state, :string
    end
  end

  def down
    change_table :tasks, bulk: true do |t|
      t.change :priority, :integer, using: 'priority::integer'
      t.change :state, :integer, using: 'state::integer'
    end
  end
end

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :task_id
      t.string :task_user
      t.string :task_title
      t.text :task_content
      t.string :task_tag
      t.integer :task_build_time
      t.integer :task_start_time
      t.integer :task_end_time
      t.integer :task_priority
      t.integer :task_state

      t.timestamps
    end
  end
end

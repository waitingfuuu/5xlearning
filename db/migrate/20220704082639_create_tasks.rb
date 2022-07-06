class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.string :tag
      t.integer :build_time
      t.integer :start_time
      t.integer :end_time
      t.integer :priority
      t.integer :state

      t.timestamps
    end
  end
end

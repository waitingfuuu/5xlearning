class ChangeStartTimeDatetime < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks, :start_time, :datetime
  end
end

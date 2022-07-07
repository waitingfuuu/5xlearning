class DeleteBuildTime < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :build_time
  end
end

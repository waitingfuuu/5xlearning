class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :_id
      t.string :username
      t.string :pw
      t.string :admin

      t.timestamps
    end
  end
end

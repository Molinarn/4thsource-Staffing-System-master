class CreateStatuses < ActiveRecord::Migration
  def up
    create_table :statuses do |t|
      t.string :name
      t.string :updated_by

      t.timestamps
   end
  end

  def down
    drop_table :statuses
  end
end
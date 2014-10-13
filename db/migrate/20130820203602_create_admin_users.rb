class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
      t.integer :candidates_id
      t.boolean :is_active
      t.integer :edited_by

      t.timestamps
    end
  end
end

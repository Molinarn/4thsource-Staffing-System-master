class AddFieldnameToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :lvl, :tinyint
    change_column :admin_users, :is_active, :boolean, default: 1
  end
end

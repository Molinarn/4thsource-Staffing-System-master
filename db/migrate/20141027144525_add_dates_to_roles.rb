class AddDatesToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :date_in, :date
    add_column :roles, :date_out, :date
    remove_column :projects_roles, :date_in
    remove_column :projects_roles, :date_out
  end
end

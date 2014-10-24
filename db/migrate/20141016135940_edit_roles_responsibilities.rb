class EditRolesResponsibilities < ActiveRecord::Migration
  def change
    rename_column :roles_responsibilities, :projects_role_id, :role_id
  end
end

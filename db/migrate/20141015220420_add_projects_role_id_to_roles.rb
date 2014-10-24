class AddProjectsRoleIdToRoles < ActiveRecord::Migration
  def change
	add_column :roles, :projects_role_id, :integer
  end
end

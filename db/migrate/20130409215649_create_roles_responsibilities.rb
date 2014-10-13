class CreateRolesResponsibilities < ActiveRecord::Migration
  def change
    create_table :roles_responsibilities do |t|
      t.integer :projects_role_id
      t.string :description

      t.timestamps
    end
  end
end

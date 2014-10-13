class CreateProjectsRoles < ActiveRecord::Migration
  def change
    create_table :projects_roles do |t|
      t.integer :project_id
      t.integer :role_id
      t.date :date_in
      t.date :date_out

      t.timestamps
    end
  end
end

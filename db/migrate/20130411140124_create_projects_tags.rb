class CreateProjectsTags < ActiveRecord::Migration
  def change
    create_table :projects_tags do |t|
      t.integer :projects_role_id
      t.integer :tags_id
      t.string :description
      t.date :date_in
      t.date :date_out

      t.timestamps
    end
  end
end

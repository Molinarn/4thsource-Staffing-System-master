class ProjectTagsTechonolgies < ActiveRecord::Migration
  def change
    create_table :projects_tags_technologies do |t|
      t.integer :project_tag_id
      t.integer :tech_id

      t.timestamps
    end
  end
end

class AddProjectsTagIdToTags < ActiveRecord::Migration
  def change
	add_column :tags, :projects_tag_id, :integer
	remove_column :projects_tags, :tags_id
  end
end

class AddDatesToTags < ActiveRecord::Migration
  def change
	add_column :tags, :date_in, :date
	add_column :tags, :date_out, :date
	remove_column :projects_tags, :date_in
	remove_column :projects_tags, :date_out
  end
end

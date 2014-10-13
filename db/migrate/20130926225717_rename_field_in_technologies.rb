class RenameFieldInTechnologies < ActiveRecord::Migration
  def change
	rename_column :technologies, :plataform_id, :lang_id
  end
end
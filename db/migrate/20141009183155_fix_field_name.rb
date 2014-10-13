class FixFieldName < ActiveRecord::Migration
  def change
	rename_column :admin_users, :candidates_id, :candidate_id
  end
end

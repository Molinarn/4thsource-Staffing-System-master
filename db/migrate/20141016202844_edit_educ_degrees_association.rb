class EditEducDegreesAssociation < ActiveRecord::Migration
  def up
	remove_column :candidate_education, :educ_degree_id
  end
  def down
	add_column :candidate_education, :educ_degree_id, :integer
  end
end

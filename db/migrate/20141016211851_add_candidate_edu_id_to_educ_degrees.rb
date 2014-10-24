class AddCandidateEduIdToEducDegrees < ActiveRecord::Migration
  def change
	add_column :educ_degrees, :candidate_education_id, :integer
  end
end

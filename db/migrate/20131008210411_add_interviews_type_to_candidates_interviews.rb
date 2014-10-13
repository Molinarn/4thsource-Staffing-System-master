class AddInterviewsTypeToCandidatesInterviews < ActiveRecord::Migration
  def change
    add_column :candidates_interviews, :interviews_type_id, :integer
    add_index :candidates_interviews, :interviews_type_id
  end
end

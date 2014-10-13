class RemoveInterviewTypeFromCandidatesInterviews < ActiveRecord::Migration
  def up
    remove_column :candidates_interviews, :interview_type_id
  end

  def down
    add_column :candidates_interviews, :interview_type_id, :integer
    add_index :candidates_interviews, :interview_type_id
  end
end

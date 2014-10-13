class RemoveInterviewerFromCandidatesInterviews < ActiveRecord::Migration
  def up
    remove_column :candidates_interviews, :interviewer_id
  end

  def down
    add_column :candidates_interviews, :interviewer_id, :integer
    add_index :candidates_interviews, :interviewer_id
  end
end

class AddInterviewerUserToCandidatesInterviews < ActiveRecord::Migration
  def change
    add_column :candidates_interviews, :interviewer_user_id, :integer
    add_index :candidates_interviews, :interviewer_user_id
  end
end

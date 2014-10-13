class AddInterviewsTypeToInterviewer < ActiveRecord::Migration
  def change
    add_column :interviewers, :interviews_type_id, :integer
    add_index :interviewers, :interviews_type_id
  end
end

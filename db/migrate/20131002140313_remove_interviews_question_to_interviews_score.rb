class RemoveInterviewsQuestionToInterviewsScore < ActiveRecord::Migration
  def up
    remove_column :interviews_scores, :interviews_question_id
  end

  def down
    add_column :interviews_scores, :interviews_question_id, :integer
    add_index :interviews_scores, :interviews_question_id
  end
end

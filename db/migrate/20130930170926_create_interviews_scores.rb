class CreateInterviewsScores < ActiveRecord::Migration
  def change
    create_table :interviews_scores do |t|
      t.decimal :score
      t.references :candidates_interview
      t.references :interviews_question

      t.timestamps
    end
    add_index :interviews_scores, :candidates_interview_id
    add_index :interviews_scores, :interviews_question_id
  end
end

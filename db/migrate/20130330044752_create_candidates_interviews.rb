class CreateCandidatesInterviews < ActiveRecord::Migration
  def change
    create_table :candidates_interviews do |t|
      t.integer :candidate_id
      t.string :result
      t.integer :interviewer_id
      t.integer :interview_type_id
      t.string :comments

      t.timestamps
    end
  end

end

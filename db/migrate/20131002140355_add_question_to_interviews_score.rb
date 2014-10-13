class AddQuestionToInterviewsScore < ActiveRecord::Migration
  def change
    add_column :interviews_scores, :question, :text
  end
end

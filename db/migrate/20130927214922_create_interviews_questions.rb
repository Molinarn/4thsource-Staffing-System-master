class CreateInterviewsQuestions < ActiveRecord::Migration
  def change
    create_table :interviews_questions do |t|
      t.string :question
      t.references :interviews_type

      t.timestamps
    end
    add_index :interviews_questions, :interviews_type_id
  end
end

class CreateInterviewerUsers < ActiveRecord::Migration
  def change
    create_table :interviewer_users do |t|
      t.references :interviewer
      t.references :candidate

      t.timestamps
    end
    add_index :interviewer_users, :interviewer_id
    add_index :interviewer_users, :candidate_id
  end
end

class CreateCandidateTrainings < ActiveRecord::Migration
  def change
    create_table :candidate_trainings do |t|
      t.integer :candidate_id
      t.string :name
      t.text :description
      t.date :year
      t.timestamps
    end
  end
end

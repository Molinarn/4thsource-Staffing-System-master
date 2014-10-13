class CreateCandidateEducation < ActiveRecord::Migration
  def up
   create_table :candidate_education do |t|
      t.integer :educ_degree_id
      t.integer :candidate_id
      t.string :title
      t.string :degree
      t.datetime :date_in
      t.datetime :date_out
      t.string :university
      t.timestamps
    end

  end

  def down
    drop_table :candidate_education
  end
end

class CreateCandidateCertifications < ActiveRecord::Migration
  def change
    create_table :candidate_certifications do |t|
      t.integer :candidate_id
      t.integer :certification_id
      t.timestamps
    end
  end
end

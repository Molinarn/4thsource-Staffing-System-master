class CreateCandidatesProfiles < ActiveRecord::Migration
  def change
    create_table :candidates_profiles do |t|
      t.integer :candidate_id
      t.string :name
      t.string :summary

      t.timestamps
    end
  end
end

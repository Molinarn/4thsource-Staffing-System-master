class CreateRCandidateTags < ActiveRecord::Migration
  def change
    create_table :r_candidate_tags do |t|
      t.integer :candidates_profile_id
      t.integer :tag_id

      t.timestamps
    end
  end
end

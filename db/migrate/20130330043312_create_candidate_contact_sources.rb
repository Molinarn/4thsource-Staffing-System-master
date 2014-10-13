class CreateCandidateContactSources < ActiveRecord::Migration
  def up
    create_table :candidate_contact_sources do |t|
      t.integer :candidate_id
      t.string :sources

      t.timestamps
    end

  end

  def down
    drop_table :candidate_contact_sources
  end
end

class CreateCandidateLanguage < ActiveRecord::Migration
  def up
  	create_table :candidate_languages do |t|
      t.integer :level_id
      t.integer :candidate_id
      t.timestamps
    end
  end

  def down
  	drop_table :candidate_languages
  end
end

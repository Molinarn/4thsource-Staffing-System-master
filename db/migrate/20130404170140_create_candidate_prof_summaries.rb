class CreateCandidateProfSummaries < ActiveRecord::Migration
  def change
    create_table :candidate_prof_summaries do |t|
	  t.string :summary
      t.integer :candidate_id
      t.timestamps
    end
  end
end
class CreateCandidatesStates < ActiveRecord::Migration
  def up
   create_table :candidates_states do |t|
     t.integer :candidate_id
     t.string :description

     t.timestamps
   end
  end

  def down
    drop_table :candidates_states
  end
end

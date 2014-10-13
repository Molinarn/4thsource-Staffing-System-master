class CreateExpertiseLevels < ActiveRecord::Migration
  def up
   create_table :expertise_levels do |t|
      t.integer :candidate_id
      t.string :name
      t.timestamps
    end

  end

  def down
      drop_table :expertise_levels
  end
end

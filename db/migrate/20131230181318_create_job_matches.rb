class CreateJobMatches < ActiveRecord::Migration
  def change
    create_table :job_matches do |t|
      t.integer :job_id
      t.integer :tag_id

      t.timestamps
    end
  end
end

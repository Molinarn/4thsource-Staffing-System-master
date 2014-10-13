class CreateResumeDetails < ActiveRecord::Migration
  def self.up
    create_table :resume_details do |t|
      t.string :summary
      t.integer :resume_id

      t.timestamps
    end
  end

  def self.down
    drop_table :resume_details
  end
end

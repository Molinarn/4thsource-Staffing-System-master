class CreateExperienceDetails < ActiveRecord::Migration
  def self.up
    create_table :experience_details do |t|
      t.integer :experience_id
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :experience_details
  end
end

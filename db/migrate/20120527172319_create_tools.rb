class CreateTools < ActiveRecord::Migration
  def self.up
    create_table :tools do |t|
      t.integer :skill_id
      t.integer :experience_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tools
  end
end

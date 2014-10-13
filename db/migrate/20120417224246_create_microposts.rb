class CreateMicroposts < ActiveRecord::Migration
  def self.up
    create_table :microposts do |t|
      t.string :content
      t.integer :candidate_id

      t.timestamps
    end
    add_index :microposts, :candidate_id
  end

  def self.down
    drop_table :microposts
  end
end

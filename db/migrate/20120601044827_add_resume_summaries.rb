class AddResumeSummaries < ActiveRecord::Migration
  def self.up
    create_table :resume_summaries do |t|
      t.integer  :resume_id
      t.string   :summary

      t.timestamps
    end
  end

  def self.down
    drop_table :resume_summaries
  end
end

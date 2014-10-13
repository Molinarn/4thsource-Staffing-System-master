class CreateResumes < ActiveRecord::Migration
  def self.up
    create_table :resumes do |t|
      t.integer  :candidate_id
      t.string     :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :resumes
  end
end

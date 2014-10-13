class CreateJobRequesters < ActiveRecord::Migration
  def change
    create_table :job_requesters do |t|
      t.string :name
      t.integer :type

      t.timestamps
    end
  end
end

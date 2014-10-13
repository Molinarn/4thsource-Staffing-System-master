class CreateJobStatuses < ActiveRecord::Migration
  def change
    create_table :job_statuses do |t|
      t.string :name
      t.integer :description

      t.timestamps
    end
  end
end

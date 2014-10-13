class AddJobAndStatusToInterview < ActiveRecord::Migration
  def change
  	add_column :candidates_interviews, :id_Job, :int
  	add_column :candidates_interviews, :status, :string
  end
end

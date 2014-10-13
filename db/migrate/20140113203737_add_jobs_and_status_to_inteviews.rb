class AddJobsAndStatusToInteviews < ActiveRecord::Migration
  def change
   rename_column :candidates_interviews, :id_Job, :jobs_id
   rename_column :candidates_interviews, :status, :statuses_id
  end
end
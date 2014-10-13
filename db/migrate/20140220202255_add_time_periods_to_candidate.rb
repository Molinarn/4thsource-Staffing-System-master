class AddTimePeriodsToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :time_periods, :string
  end
end

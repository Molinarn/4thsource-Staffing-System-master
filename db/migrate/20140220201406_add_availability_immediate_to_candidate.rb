class AddAvailabilityImmediateToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :availability_Immediate, :boolean
  end
end

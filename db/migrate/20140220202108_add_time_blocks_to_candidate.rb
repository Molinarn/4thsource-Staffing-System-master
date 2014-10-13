class AddTimeBlocksToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :time_blocks, :integer
  end
end

class RemoveCertificationIdInCandidate < ActiveRecord::Migration
  def up
    remove_column :candidates, :certifcations
  end

  def down
  end
end

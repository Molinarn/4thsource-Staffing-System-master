class RemoveTypeToCandidates < ActiveRecord::Migration
  def up
    remove_column :candidates, :type
  end

  def down
    add_column :candidates, :type, :string
  end
end

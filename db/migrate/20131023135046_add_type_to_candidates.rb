class AddTypeToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :type, :string
  end
end

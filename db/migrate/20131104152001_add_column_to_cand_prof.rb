class AddColumnToCandProf < ActiveRecord::Migration
  def change
    add_column :candidates_profiles, :profiledata, :string
  end
end

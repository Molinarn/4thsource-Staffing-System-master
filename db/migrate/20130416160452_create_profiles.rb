class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :description
      t.boolean :approved_flag
      t.string :approved_by 
      
      t.timestamps
    end
  end
end

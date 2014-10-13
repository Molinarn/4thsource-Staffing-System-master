class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :candidate_id
      t.string :name
      t.string :summary
      t.string :company_name
      

      t.timestamps
    end
  end
end
class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :comments

      t.timestamps
    end
    
    Office.create(:name => 'Merida', :address => 'Carr. Progreso km 12', :city => 'Yucatan', :comments => 'Headquarters Mexico')
    Office.create(:name => 'Colima', :address => 'Venustiano Carranza #1360, Santa Barbara', :city => 'Colima', :comments => 'Secondary office')
    Office.create(:name => 'Mexico City', :address => 'World Trade Center', :city => 'Distrito Federal', :comments => 'New Office')
    Office.create(:name => 'La Paz', :address => 'N/A', :city => 'Baja California Sur', :comments => 'In plans')
    
    
  end
end

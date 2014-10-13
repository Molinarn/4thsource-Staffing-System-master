class CreateEducationDegrees < ActiveRecord::Migration
  def up
    create_table :education_degrees do |t|
      t.integer :id
      t.string :name
      t.string :description
      t.boolean :approved_flag
      t.string :approved_by

      t.timestamps
   end
   
   EducationDegrees.create(:name => "Junior High School", :description => "Secundaria", :approved_flag=>1, :approved_by=>'System')
   EducationDegrees.create(:name => "High School", :description => "Bachiller", :approved_flag=>1, :approved_by=>'System')
   EducationDegrees.create(:name => "Bachelor's degree", :description => "Universidad", :approved_flag=>1, :approved_by=>'System')
   EducationDegrees.create(:name => "Master", :description => "Postgrado", :approved_flag=>1, :approved_by=>'System')
   EducationDegrees.create(:name => "Doctors Degree", :description => "Doctorado", :approved_flag=>1, :approved_by=>'System')
   EducationDegrees.create(:name => "unfinished", :description => "unfinished", :approved_flag=>1, :approved_by=>'System')
   
  end

  def down
    drop_table :education_degrees
  end
end
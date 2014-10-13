class CreateEducDegree < ActiveRecord::Migration
  def up
    create_table :educ_degrees do |t|
      t.string :name
      t.string :description
      t.boolean :approved_flag
      t.string :approved_by
      t.timestamps
    end

   EducDegree.create(:name => "Junior High School", :description => "Secundaria", :approved_flag=>1, :approved_by=>'System')
   EducDegree.create(:name => "High School", :description => "Bachiller", :approved_flag=>1, :approved_by=>'System')
   EducDegree.create(:name => "Bachelor's degree", :description => "Universidad", :approved_flag=>1, :approved_by=>'System')
   EducDegree.create(:name => "Master", :description => "Postgrado", :approved_flag=>1, :approved_by=>'System')
   EducDegree.create(:name => "Doctors Degree", :description => "Doctorado", :approved_flag=>1, :approved_by=>'System')
   EducDegree.create(:name => "unfinished", :description => "unfinished", :approved_flag=>1, :approved_by=>'System')

  end

  def down
    drop_table :educ_degrees
  end
end

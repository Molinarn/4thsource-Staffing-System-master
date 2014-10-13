class CreateCertification < ActiveRecord::Migration
  def up
   create_table :certifications do |t|
     t.integer :id
     t.string :name
     t.string :description
     t.boolean :approved_flag
     t.string :approved_by

     t.timestamps
   end
   
   Certification.create(:name => "COBOL II Programmer", :description => '')
   Certification.create(:name => "DB2 administration zOS", :description => '')
   Certification.create(:name => "ABAP Programmer", :description => '')
   Certification.create(:name => "Java Programmer 6 Certification 1Z0-851", :description => '')
   
  end

  def down
    drop_table :certifications
  end
end
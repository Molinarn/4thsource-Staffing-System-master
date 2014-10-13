class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :type_tag
      t.string :name
      t.string :description

      t.timestamps
    end

    Tag.create(:type_tag => 2, :name =>  "JAVA", :description => "")
    Tag.create(:type_tag => 1, :name =>  "ORACLE", :description => "")
    Tag.create(:type_tag => 3, :name =>  ".NET", :description => "")
    Tag.create(:type_tag => 2, :name =>  "SQL", :description => "")
    Tag.create(:type_tag => 2, :name =>  "MYSQL", :description => "")
    Tag.create(:type_tag => 1, :name =>  "netbeans", :description => "")
    Tag.create(:type_tag => 3, :name =>  "COBOL", :description => "")
    Tag.create(:type_tag => 2, :name =>  "zOS", :description => "")
    Tag.create(:type_tag => 3, :name =>  "DB2", :description => "")
    Tag.create(:type_tag => 2, :name =>  "C#", :description => "")
    Tag.create(:type_tag => 2, :name =>  "PHP", :description => "")
    Tag.create(:type_tag => 2, :name =>  "JavaScript", :description => "")
    Tag.create(:type_tag => 2, :name =>  "JQuery", :description => "")
    Tag.create(:type_tag => 2, :name =>  "CSS", :description => "")
    Tag.create(:type_tag => 2, :name =>  "XHTML", :description => "")
    Tag.create(:type_tag => 2, :name =>  "HTML", :description => "")
    Tag.create(:type_tag => 1, :name =>  ".NET", :description => "")
    Tag.create(:type_tag => 3, :name =>  "ORACLE", :description => "")


  end
end

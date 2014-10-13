class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :description
      t.boolean :approved_flag
      t.string :approved_by

      t.timestamps
    end
  
  Role.create(:name => "Architect", :description => '', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => "Consultant", :description => '', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => "Project manager", :description => '', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => "Analyst Programmer", :description => '', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => "IT specialist", :description => '', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => "Data seeding specialist", :description => '', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => "System Analyst", :description => '', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => "Project Leader", :description => '', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => "developer", :description => '', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => "IT Manager", :description => '', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => "Editor", :description => '', :approved_flag => 1, :approved_by => 'System')
  Role.create(:name => "Application Support", :description => '', :approved_flag => 1, :approved_by => 'System')
  
  end
end

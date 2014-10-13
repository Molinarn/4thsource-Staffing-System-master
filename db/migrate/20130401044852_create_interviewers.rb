class CreateInterviewers < ActiveRecord::Migration
  def change
    create_table :interviewers do |t|
      t.string :name
      t.string :updated_by
      t.timestamps
    end

  Interviewer.create(:name => 'Adan Carrasco', :updated_by => 'System')
  Interviewer.create(:name => 'Rodolfo Baeza', :updated_by => 'System')
  Interviewer.create(:name => 'Omar Esparza', :updated_by => 'System')
  Interviewer.create(:name => 'Ivan Lopez', :updated_by => 'System')
  Interviewer.create(:name => 'Gilda Dzul', :updated_by => 'System')
  Interviewer.create(:name => 'Ariel Parra', :updated_by => 'System')
  end

end

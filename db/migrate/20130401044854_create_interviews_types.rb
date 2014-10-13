class CreateInterviewsTypes < ActiveRecord::Migration
  def change
    create_table :interviews_types do |t|
      t.string :name
      t.timestamps
    end

  InterviewsType.create(:name => 'First contact')
  InterviewsType.create(:name => 'English')
  InterviewsType.create(:name => 'Technical')
  InterviewsType.create(:name => 'Manager')
  InterviewsType.create(:name => 'Client')

  end

end

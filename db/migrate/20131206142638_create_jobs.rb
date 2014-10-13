class CreateJobs < ActiveRecord::Migration
	def change
		create_table :jobs do |t|
			t.string :title
      		t.string :description
      		t.string :other_requirements
      		t.references :admin_users

	      t.timestamps
    	end
  	end
end

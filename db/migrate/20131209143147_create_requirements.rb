class CreateRequirements < ActiveRecord::Migration
	def change
		create_table :requirements do |t|
	  		t.belongs_to :job
	  		t.belongs_to :tag
      		t.integer :minimum_experience

      		t.timestamps
    	end
  	end
end

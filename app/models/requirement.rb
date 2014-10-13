class Requirement < ActiveRecord::Base
	attr_accessible :id,
					:minimum_experience

	belongs_to :job
	belongs_to :tag

end

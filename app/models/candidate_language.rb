class CandidateLanguage < ActiveRecord::Base
  attr_accessible  :level_id
      			   
  belongs_to       :candidate
  has_one          :filter_language, :dependent => :destroy
  has_one          :language,   :through => :filter_language 

  validates :level_id , :presence => true
end

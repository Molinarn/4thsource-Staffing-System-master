class CandidateLanguage < ActiveRecord::Base
  attr_accessible  :level_id, :language_id, :candidate_id
      			   
  belongs_to       :candidate
  has_many          :filter_languages, :dependent => :destroy
  #has_one          :language,   :through => :filter_language 
  
  #belongs_to       :language

  #validates :level_id , :presence => true
end

class FilterLanguage < ActiveRecord::Base
  
  attr_accessible  :level_id, :candidate_language_id, :language_id
  
  belongs_to :candidate_language
  belongs_to :language
  
  #has_many :languages
  
  validates :level_id , :presence => true
  
end

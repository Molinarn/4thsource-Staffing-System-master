class FilterLanguage < ActiveRecord::Base
  
  #belongs_to :f_languages, :polymorphic => true
  
  belongs_to :candidate_language
  #belongs_to :language
  #has_many :languages
end

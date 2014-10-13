class FilterLanguage < ActiveRecord::Base
  belongs_to :candidate_language
  belongs_to :language
end

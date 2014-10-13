class Language < ActiveRecord::Base
  attr_accessible :id,
          :name,
		  :description,
          :approved_flag,
		  :approved_by
  validates :name, :presence => true, :length => { :maximum => 50 }
  
  def used
    (FilterLanguage.where("language_id = ?", id).length > 0)  
  end
  
end

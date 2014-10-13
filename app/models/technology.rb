class Technology < ActiveRecord::Base
  attr_accessible :id,
                  :lang_id, 
                  :technology, 
                  :created_at,
                  :updated_at

  has_many :projects_tag, :dependent => :destroy
  
  def used
    (ProjectsTag.where("tags_id = ?", id).length > 0)  
  end
  
end

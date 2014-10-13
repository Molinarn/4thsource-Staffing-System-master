class Skill < ActiveRecord::Base
  
  attr_accessible :name,
                  :version
  
  has_many :tools
  has_many :experiences, :through => :tools
  
  validates :name, :presence => true
  validates :version, :presence => true
  
  def name_and_version
    if version.nil?
      name
    else
      name + ' ' +  version
    end
  end
  
end

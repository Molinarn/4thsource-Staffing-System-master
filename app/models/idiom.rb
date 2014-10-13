class Idiom < ActiveRecord::Base
  
  belongs_to :resume
  
  validates :name, :presence => true, :length => { :maximum => 50 }
  validates :level, :presence => true
  
end

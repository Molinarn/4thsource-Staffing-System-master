class Status < ActiveRecord::Base
  attr_accessible :name,
                  :updated_by

  has_many :candidates, :dependent => :destroy
  
  validates :name, :presence => true
end

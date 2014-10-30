class Job < ActiveRecord::Base
  
  attr_accessor :tag_id
  
  attr_accessible :id,
  				  :title,
  				  :description,
  				  :other_requirements,
  				  :admin_users_id,
  				  :users_id,
  				  :tag_id

  has_many :job_matchs
  has_many :tags, :through => :job_matchs
  #belongs_to :admin_users

  #has_many :requirements
  #has_many :tags, through: :requirements

  validate :title, :presence => true
  validate :description, :presence => true


end


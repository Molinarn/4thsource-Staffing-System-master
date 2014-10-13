class Office < ActiveRecord::Base
  attr_accessible :address, :city, :comments, :name
end

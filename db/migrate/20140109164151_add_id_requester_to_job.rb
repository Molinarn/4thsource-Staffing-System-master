class AddIdRequesterToJob < ActiveRecord::Migration
  def change
  	 add_column :jobs, :id_requester, :int
  	 add_column :jobs, :id_status, :int
  	 add_column :jobs, :id_parent, :int
  end
end

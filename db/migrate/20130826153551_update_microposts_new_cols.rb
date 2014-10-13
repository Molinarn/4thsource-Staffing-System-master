class UpdateMicropostsNewCols < ActiveRecord::Migration
  def change
  	add_column :microposts, :created_by, :integer
  	add_column :microposts, :checked, :tinyint
  end
end

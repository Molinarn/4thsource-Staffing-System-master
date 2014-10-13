class MicropostUpdateIsActiveField < ActiveRecord::Migration
  def change
  	add_column :microposts, :is_active, :boolean
  end
end

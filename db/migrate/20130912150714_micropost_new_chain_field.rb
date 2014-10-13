class MicropostNewChainField < ActiveRecord::Migration
  def change
  	add_column :microposts, :chain_id, :integer
  end
end

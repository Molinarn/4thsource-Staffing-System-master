class AddLastNamesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_name, :string
    add_column :users, :second_last_name, :string
  end

  def self.down
    remove_column :users, :last_name
    remove_column :users, :second_last_name
  end
end

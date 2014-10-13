class ChangePasswordFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :change_password_flag, :string
  end

  def self.down
    remove_column :users, :change_password_flag
  end
end

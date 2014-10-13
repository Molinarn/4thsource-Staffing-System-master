class AddContactToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :gender, :string
    add_column :users, :birthday, :date
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :zip_code, :bigint
    add_column :users, :country, :string
    add_column :users, :home_phone, :bigint
    add_column :users, :office_phone, :bigint
    add_column :users, :cell_phone, :bigint
  end

  def self.down
    remove_column :users, :cell_phone
    remove_column :users, :office_phone
    remove_column :users, :home_phone
    remove_column :users, :country
    remove_column :users, :zip_code
    remove_column :users, :city
    remove_column :users, :address
    remove_column :users, :birthday
    remove_column :users, :gender
  end
end

class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.integer :status_id
      t.integer :techonlogy_id
      t.string :name
      t.string :gender
      t.datetime :birthdate
      t.string :university
      t.string :degree
      t.integer :graduation_year
      t.string :certifcations
      t.string :address
      t.string :email
      #t.string :telephone
      #t.string :mobile
      #t.string :office_telephone
      t.boolean :has_visa
      t.integer :visa_expiration_year
      t.boolean :has_passport
      t.integer :passport_expiration_year
      t.boolean :is_willing_to_travel
      t.boolean :is_willing_to_relocate
      t.boolean :currently_employed
      t.integer :marital_status
      t.string :company
      t.string :position
      t.integer :salary_expectancy
      t.integer :current_salary
      t.string :comments
      t.string :first_name
      t.string :middle_name
      t.string :first_last_name
      t.string :second_last_name
      t.string :address1
      t.string :neighborhood
      t.string :city
      t.string :country
      t.integer :zip_code
      t.string :home_phone
      t.string :cell_phone
      t.string :office_phone
      t.boolean :change_password_flag
      t.string :encrypted_password
      t.string :salt
      #t.string :avatar_file_name
      t.datetime :created_at
      t.integer :resume_id
      t.datetime :updated_at
      t.integer :updated_by
      t.has_attached_file :avatar
      t.boolean :admin_flag
      t.boolean :currently_in_4Source
      t.datetime :recruited_at
      t.datetime :started_at
      t.integer :office_id
      t.string :email_alternate_1
      t.string :email_alternate_2
      t.string :email_alternate_3

      t.timestamps
    end
  end
end

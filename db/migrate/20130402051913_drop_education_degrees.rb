class DropEducationDegrees < ActiveRecord::Migration
  def change
    drop_table :education_degrees
  end
end
class TechTable < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.integer :plataform_id
      t.string :technology

      t.timestamps
    end
  end
end

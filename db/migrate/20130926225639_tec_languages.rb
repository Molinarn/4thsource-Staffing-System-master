class TecLanguages < ActiveRecord::Migration
  def change
    create_table :tec_languages do |t|
      t.string :language
      t.boolean :is_active

      t.timestamps
    end
  end
end

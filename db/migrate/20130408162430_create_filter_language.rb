class CreateFilterLanguage < ActiveRecord::Migration
  def up
  	create_table :filter_languages do |t|
      t.integer :candidate_language_id
      t.integer :language_id
      t.timestamps
    end
  end

  def down
  	drop_table :filter_languages
  end
end

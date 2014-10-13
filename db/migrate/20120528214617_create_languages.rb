class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :name
      t.string :description
      t.boolean :approved_flag
      t.string :approved_by

      t.timestamps
    end
    
    Language.create(:name => "Spanish", :description => '')
    Language.create(:name => "English", :description => '')
    Language.create(:name => "German", :description => '')
    Language.create(:name => "Japanese", :description => '')
    Language.create(:name => "French", :description => '')
    Language.create(:name => "Portuguese", :description => '')
    Language.create(:name => "Mandarin", :description => '')
  end

  def self.down
    drop_table :languages
  end
end

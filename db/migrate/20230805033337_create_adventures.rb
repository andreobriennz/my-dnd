class CreateAdventures < ActiveRecord::Migration[7.0]
  def change
    create_table :adventures do |t|
      t.string :title
      t.string :subtitle
      t.text :description

      t.boolean :public, :default => false
      t.boolean :archived, :default => false

      t.text :private_notes
      t.text :shared_notes
  
      t.date :date_started

      t.string :slug
      t.string :campaign_slug
      t.string :user_id

      t.timestamps
    end
  end
end
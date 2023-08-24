class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.string :title
      t.string :subtitle
      t.text :description

      t.boolean :public, :default => false
      t.boolean :archived, :default => false

      t.text :private_notes
      t.text :shared_notes
  
      t.date :date_started
      t.date :date_ended

      t.string :slug

      t.timestamps
    end
  end
end

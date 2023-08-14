class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :adventure, foreign_key: true
      t.references :campaign, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

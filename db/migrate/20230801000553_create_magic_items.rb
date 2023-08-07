class CreateMagicItems < ActiveRecord::Migration[7.0]
  def change
    create_table :magic_items do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest

      t.timestamps
    end
    
    add_column :users, :saved_magic_items, :string, array:true, default: []
    add_column :users, :saved_spells, :string, array:true, default: []
  end
end

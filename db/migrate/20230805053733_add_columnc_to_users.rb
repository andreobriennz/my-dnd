class AddColumncToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :saved_monsters, :string, array:true, default: []
    add_column :users, :saved_weapons, :string, array:true, default: []
    add_column :users, :saved_armor, :string, array:true, default: []
  end
end

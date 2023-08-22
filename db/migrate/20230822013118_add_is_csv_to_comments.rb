class AddIsCsvToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :is_csv, :boolean
  end
end

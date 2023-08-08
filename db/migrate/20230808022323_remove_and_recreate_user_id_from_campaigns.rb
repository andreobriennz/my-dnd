class RemoveAndRecreateUserIdFromCampaigns < ActiveRecord::Migration[7.0]
  def change
    remove_column :campaigns, :user_id
    add_reference :campaigns, :user, foreign_key: true
  end
end
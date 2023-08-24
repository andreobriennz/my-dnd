class RemoveAndRecreateUserIdFromCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_reference :campaigns, :user, foreign_key: true
  end
end
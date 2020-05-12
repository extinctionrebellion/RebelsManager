class AddPhoneCampaignFieldsToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :phone_campaign_status, :string
    add_column :rebels, :phone_campaign_notes, :text
  end
end

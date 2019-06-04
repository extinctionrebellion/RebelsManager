class AddConsentToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :consent, :boolean
  end
end

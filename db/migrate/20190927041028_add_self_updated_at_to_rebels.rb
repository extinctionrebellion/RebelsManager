class AddSelfUpdatedAtToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :self_updated_at, :datetime
  end
end

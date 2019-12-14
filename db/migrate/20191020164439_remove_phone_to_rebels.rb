class RemovePhoneToRebels < ActiveRecord::Migration[6.0]
  def change
    remove_column :rebels, :phone
  end
end

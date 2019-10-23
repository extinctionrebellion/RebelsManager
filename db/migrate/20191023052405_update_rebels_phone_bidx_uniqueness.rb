class UpdateRebelsPhoneBidxUniqueness < ActiveRecord::Migration[6.0]
  def change
    remove_index :rebels, :phone_bidx
    add_index :rebels, :phone_bidx, unique: false
  end
end

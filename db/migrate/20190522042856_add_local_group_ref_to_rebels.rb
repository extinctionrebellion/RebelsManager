class AddLocalGroupRefToRebels < ActiveRecord::Migration[6.0]
  def change
    add_reference :rebels, :local_group, foreign_key: true
  end
end

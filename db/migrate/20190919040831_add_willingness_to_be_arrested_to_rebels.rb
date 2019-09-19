class AddWillingnessToBeArrestedToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :willingness_to_be_arrested, :boolean
  end
end

class AddIrlToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :irl, :boolean
  end
end

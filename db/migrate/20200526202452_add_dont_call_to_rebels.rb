class AddDontCallToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :dont_call, :boolean
  end
end

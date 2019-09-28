class RemoveOnBasecampFromRebels < ActiveRecord::Migration[6.0]
  def change
    remove_column :rebels, :on_basecamp
  end
end

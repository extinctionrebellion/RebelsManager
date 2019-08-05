class AddInternalNotesToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :internal_notes, :text
  end
end

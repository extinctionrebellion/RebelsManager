class AddStatusToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :status, :string
  end
end

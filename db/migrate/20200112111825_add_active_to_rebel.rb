class AddActiveToRebel < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :active, :boolean, default: :true
  end
end

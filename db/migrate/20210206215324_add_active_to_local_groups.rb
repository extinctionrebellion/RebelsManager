class AddActiveToLocalGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :local_groups, :active, :boolean, default: true
  end
end

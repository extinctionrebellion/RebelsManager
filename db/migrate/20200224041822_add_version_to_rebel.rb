class AddVersionToRebel < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :version, :integer, default: 1
  end
end

class AddAgreeWithPrinciplesToRebel < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :agree_with_principles, :boolean
  end
end

class AddSourceToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :source, :string
  end
end

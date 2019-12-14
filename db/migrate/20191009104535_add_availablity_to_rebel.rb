class AddAvailablityToRebel < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :availability, :string
  end
end

class AddTokenToRebels < ActiveRecord::Migration[6.0]
  def change
    add_column :rebels, :token, :string
  end
end

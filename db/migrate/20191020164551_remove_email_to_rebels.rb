class RemoveEmailToRebels < ActiveRecord::Migration[6.0]
  def change
    remove_column :rebels, :email
  end
end
